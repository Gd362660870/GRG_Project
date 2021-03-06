
//
//  ScannerViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/10.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "ScannerViewController.h"
#import "ScannerViewModel.h"
#import "UIImageView+Scanner.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ScannerViewModel ()<AVCaptureMetadataOutputObjectsDelegate,
                               UINavigationControllerDelegate,
                               UIImagePickerControllerDelegate>

@property(nonatomic, weak) ScannerViewController* View;
@property(nonatomic, assign) BOOL isOpenSpark;

/**
 *  打开相册
 */
-(void)openPhotos;

@end

@implementation ScannerViewModel

- (instancetype)initWithController:(id)controller {
  self = [super init];
  if (self) {
    self.View = controller;

    //访问摄像头
//      [self accessCamera];
    //处理信号
    [self processingSignal];
  }
  return self;
}

#pragma mark - 访问摄像头
- (BOOL)accessCamera {
  NSString* mediaType = AVMediaTypeVideo;
    [CJJ_Tools sharedTools].videoAuthStatus =
      [[CJJ_Tools sharedTools] getVideoAuthStatus];

  switch ([CJJ_Tools sharedTools].videoAuthStatus) {
    case AVAuthorizationStatusNotDetermined: {
      NSLog(@"不确定");

      // 媒体捕获需要显式的用户权限，但用户尚未授予或拒绝这样的权限。
      [AVCaptureDevice requestAccessForMediaType:mediaType
                               completionHandler:^(BOOL granted) {
                                 if (granted) {  //点击允许访问时调用
                                   //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                                   NSLog(@"授予访问 %@", mediaType);
                                 } else {
                                   NSLog(@"未授予访问权限 %@", mediaType);
                                 }

                               }];
    }

    break;

    case AVAuthorizationStatusRestricted: {
      NSLog(@"收限制");
    }

    break;

    case AVAuthorizationStatusDenied: {
      NSLog(@"拒绝");
        
        return YES;

    }

    break;

    case AVAuthorizationStatusAuthorized:
      NSLog(@"已授权");
      break;

    default:
      break;
  }
    return NO;
}

#pragma mark - 处理信号
- (void)processingSignal {
  // 1 判断是否存在相机
  if ([self accessCamera]) {
    [self showAlertViewWithTitle:@"警告" withMessage:@"未检测到相机"];
      
    return;
  }

  //初始化扫描
  [self scanSetup];
}

#pragma mark -初始化扫描配置
- (void)scanSetup {
  // 2 添加预览图层
  self.preview.frame = self.View.view.bounds;
  self.preview.videoGravity = AVLayerVideoGravityResize;
  [self.View.view.layer insertSublayer:self.preview atIndex:0];

  // 3 设置输出能够解析的数据类型
  //注意:设置数据类型一定要在输出对象添加到回话之后才能设置
  [self.output setMetadataObjectTypes:@[
    AVMetadataObjectTypeEAN13Code,
    AVMetadataObjectTypeEAN8Code,
    AVMetadataObjectTypeCode128Code,
    AVMetadataObjectTypeQRCode
  ]];

  //高质量采集率
  [self.session setSessionPreset:AVCaptureSessionPresetHigh];

  // 4 开始扫描
  [self.session startRunning];
}

#pragma mark -提示框alert
- (void)showAlertViewWithMessage:(NSString*)message {
  @weakify(self)
      //弹出提示框后，关闭扫描
      [self.session stopRunning];
  //弹出alert，关闭定时器
  [[CJJ_Tools sharedTools].animation isShopScanAnimation:YES];

  UIAlertController* alert = [UIAlertController
      alertControllerWithTitle:@"image"
                       message:[NSString stringWithFormat:@"扫描结果：%@",
                                                          message]
                preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction
                       actionWithTitle:@"tishi"
                                 style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction* _Nonnull action) {
                                 @strongify(self)
                                     //点击alert，开始扫描
                                     [self.session startRunning];
                                 //开启定时器
                                 [[CJJ_Tools sharedTools]
                                         .animation isShopScanAnimation:NO];

                               }]];
  [self.View presentViewController:alert
                          animated:true
                        completion:^{

                        }];
}

#pragma mark - 开打与关闭闪光灯
- (void)systemLightSwitch:(BOOL)open {
  AVCaptureDevice* device =
      [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  if ([device hasTorch]) {
    [device lockForConfiguration:nil];
    if (open) {
      [device setTorchMode:AVCaptureTorchModeOn];
    } else {
      [device setTorchMode:AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];
  }
}

#pragma mark - ===========从相册读取二维码并扫描===========

//点击选择按钮
- (void)chooseButtonClick {
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if (author == AVAuthorizationStatusRestricted || author == AVAuthorizationStatusDenied){
        
        [self showAlertViewWithTitle:@"警告" withMessage:@"未检测到相册"];
        
    }else
    {
        [self openPhotos];
    }
 
}

//打开相册
-(void)openPhotos
{
    if ([UIImagePickerController
         isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) {
        //关闭扫描器
        [self.eventSubject sendNext:@(ScannerViewModelTypeStop)];
        
        
        // 1 弹出系统相册
        UIImagePickerController* pickVC = [[UIImagePickerController alloc] init];
        // 2 设置照片来源
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        // 3 设置代理
        pickVC.delegate = self;
        // 4.随便给他一个转场动画
        self.View.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self.View presentViewController:pickVC animated:YES completion:nil];
        
    } else {
        [self showAlertViewWithTitle:@"打开失败"
                         withMessage:@"相"
         @"册"
         @"打开失败。设备不支持访问相册，请在设置-"
         @">"
         @"隐私->照片中进行设置！"];
    }

}

//从相册中选取照片&读取相册二维码信息
- (void)imagePickerController:(UIImagePickerController*)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString*, id>*)info {
  // 1 获取选择的图片
  UIImage* image = info[UIImagePickerControllerOriginalImage];
  //初始化一个监听器
  CIDetector* detector = [CIDetector
      detectorOfType:CIDetectorTypeQRCode
             context:nil
             options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
  [picker
      dismissViewControllerAnimated:YES
                         completion:^{
                           //监测到的结果数组
                           NSArray* features = [detector
                               featuresInImage:
                                   [CIImage imageWithCGImage:image.CGImage]];
                           if (features.count >= 1) {
                             //结果对象
                             CIQRCodeFeature* feature =
                                 [features objectAtIndex:0];
                             NSString* scannedResult = feature.messageString;
                             [self
                                 showAlertViewWithTitle:@"读取相册二维码"
                                            withMessage:scannedResult];
                           } else {
                             [self
                                 showAlertViewWithTitle:@"读取相册二维码"
                                            withMessage:@"读取失败"];
                           }
                         }];
}

#pragma mark - ===========扫描的代理方法===========
//得到扫描结果
- (void)captureOutput:(AVCaptureOutput*)captureOutput
    didOutputMetadataObjects:(NSArray*)metadataObjects
              fromConnection:(AVCaptureConnection*)connection {
  if ([metadataObjects count] > 0) {
    AVMetadataMachineReadableCodeObject* metadataObject =
        [metadataObjects objectAtIndex:0];
    if ([metadataObject
            isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
      NSString* stringValue = [metadataObject stringValue];
      if (stringValue != nil) {
        [self.session stopRunning];
        //扫描结果
        self.scannedResult = stringValue;
        NSLog(@"%@", stringValue);
        [self showAlertViewWithMessage:stringValue];
      }
    }
  }
}

#pragma mark - ===========添加提示框===========
//提示框alert
- (void)showAlertViewWithTitle:(NSString*)aTitle
                   withMessage:(NSString*)aMessage {
  [self.eventSubject sendNext:@(ScannerViewModelTypeStop)];

  UIAlertController* alert = [UIAlertController
      alertControllerWithTitle:aTitle
                       message:[NSString stringWithFormat:@"%@", aMessage]
                preferredStyle:UIAlertControllerStyleAlert];
    
    if ([aMessage isEqualToString:@"未检测到相机"] || [aMessage isEqualToString:@"未检测到相册"]) {
        [alert addAction:[UIAlertAction
                          actionWithTitle:@"设置"
                          style:UIAlertActionStyleCancel
                          handler:^(UIAlertAction* _Nonnull action) {
                              
                              [self.eventSubject
                               sendNext:@(ScannerViewModelTypeStart)];
                              //跳转到系统设置
                              if ([aMessage isEqualToString:@"未检测到相机"]) {
                                  OPEN_CAMERA;
                                  [self.View.navigationController popViewControllerAnimated:YES];
                              }else if ([aMessage isEqualToString:@"未检测到相册"])
                              {
                                  OPEN_PHOTOS;
                                  [self openPhotos];
                              }
                              
                              
                              
                          }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.eventSubject
             sendNext:@(ScannerViewModelTypeStart)];
            if ([aMessage isEqualToString:@"未检测到相机"]) {
                //跳转上个页面
                [self.View.navigationController popViewControllerAnimated:YES];
            }else if ([aMessage isEqualToString:@"未检测到相册"])
            {
                [self openPhotos];
            }
            
            
            
        }]];
    }else
    {
        [alert addAction:[UIAlertAction
                          actionWithTitle:@"确定"
                          style:UIAlertActionStyleCancel
                          handler:^(UIAlertAction* _Nonnull action) {
                              
                              [self.eventSubject
                               sendNext:@(ScannerViewModelTypeStart)];
                              
                          }]];
    }
    
  
  [self.View presentViewController:alert
                          animated:true
                        completion:^{

                        }];
}

#pragma mark - 所有按钮的触发事件
- (RACSubject*)btnSubject {
  if (!_btnSubject) {
    _btnSubject = [RACSubject subject];
    @weakify(self)
        //处理所有按钮的信号
        [_btnSubject subscribeNext:^(UIImageView* x) {
          @strongify(self) switch (x.type) {
            case UIImageViewScannerTypeReturn:
              [self.View.navigationController popViewControllerAnimated:YES];
              [self systemLightSwitch:NO];
              NSLog(@"返回");
              break;
            case UIImageViewScannerTypePrint:
              NSLog(@"相册");
              //打开相册
              [self chooseButtonClick];
              break;
            case UIImageViewScannerTypeSpark:
              NSLog(@"闪光灯");
              self.isOpenSpark = !self.isOpenSpark;
              [self systemLightSwitch:self.isOpenSpark];
              break;

            default:
              break;
          }
        }];
  }
  return _btnSubject;
}
#pragma mark - 所有事件信号
- (RACSubject*)eventSubject {
  if (!_eventSubject) {
    _eventSubject = [RACSubject subject];
    @weakify(self)[_eventSubject subscribeNext:^(id x) {
      @strongify(self) ScannerViewModelType type = [x integerValue];
      switch (type) {
        case ScannerViewModelTypeStart:  //开启扫描
          [self.session startRunning];
          [[CJJ_Tools sharedTools].animation isShopScanAnimation:NO];
          break;
        case ScannerViewModelTypeStop:  //关闭扫描
          [self.session stopRunning];
          [[CJJ_Tools sharedTools].animation isShopScanAnimation:YES];
          break;
        default:
          break;
      }
    }];
  }
  return _eventSubject;
}

#pragma mark -dealloc
- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark -懒加载
//数据模型
- (ScannerModel*)model {
  if (!_model) {
    _model = [[ScannerModel alloc] init];
  }
  return _model;
}

//获取appDelegate
- (AppDelegate*)appDelegate {
  if (!_appDelegate) {
    _appDelegate = [UIApplication sharedApplication].delegate;
  }
  return _appDelegate;
}

// device
- (AVCaptureDevice*)device {
  if (_device == nil) {
    // AVMediaTypeVideo是打开相机
    // AVMediaTypeAudio是打开麦克风
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  }
  return _device;
}
// input
- (AVCaptureDeviceInput*)input {
  if (_input == nil) {
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
  }
  return _input;
}
// output  --- output如果不打开就无法输出扫描得到的信息
// 设置输出对象解析数据时感兴趣的范围
// 默认值是 CGRect(x: 0, y: 0, width: 1, height: 1)
// 通过对这个值的观察, 我们发现传入的是比例
// 注意: 参照是以横屏的左上角作为, 而不是以竖屏
//        out.rectOfInterest = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
- (AVCaptureMetadataOutput*)output {
  if (_output == nil) {
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //限制扫描区域(上下左右)
    [_output
        setRectOfInterest:[self rectOfInterestByScanViewRect:self.View.imageView
                                                                 .frame]];
  }
  return _output;
}

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
  //    CGRect rect = ;
  CGFloat width = CGRectGetWidth(self.View.view.frame);
  CGFloat height = CGRectGetHeight(self.View.view.frame);

  CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
  CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;

  CGFloat w = CGRectGetHeight(rect) / height;
  CGFloat h = CGRectGetWidth(rect) / width;

  return CGRectMake(x, y, w, h);
}


// session
- (AVCaptureSession*)session {
  if (_session == nil) {
    // session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]) {
      [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]) {
      [_session addOutput:self.output];
    }
  }
  return _session;
}
// preview
- (AVCaptureVideoPreviewLayer*)preview {
  if (_preview == nil) {
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
  }
  return _preview;
}

@end
