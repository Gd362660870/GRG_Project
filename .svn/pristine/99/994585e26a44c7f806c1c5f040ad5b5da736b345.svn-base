
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

@interface ScannerViewModel ()<AVCaptureMetadataOutputObjectsDelegate,
                               UINavigationControllerDelegate,
                               UIImagePickerControllerDelegate>

@property(nonatomic, weak) ScannerViewController *View;
@property(nonatomic, assign) BOOL isOpenSpark;

@end

@implementation ScannerViewModel

- (instancetype)initWithController:(id)controller {
  self = [super init];
  if (self) {
    self.View = controller;
    //处理信号
    [self processingSignal];
  }
  return self;
}

#pragma mark - 处理信号
- (void)processingSignal {
}

#pragma mark - 开打与关闭闪光灯
- (void)systemLightSwitch:(BOOL)open {
  AVCaptureDevice *device =
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

#pragma mark ===========从相册读取二维码并扫描===========

//打开系统相册
- (void)chooseButtonClick {
  if ([UIImagePickerController
          isSourceTypeAvailable:
              UIImagePickerControllerSourceTypePhotoLibrary]) {
    //关闭扫描器
//    [self.eventSubject sendNext:@(ScannerViewModelTypeStop)];
      [self.session stopRunning];

    // 1 弹出系统相册
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
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
    [self
        showAlertViewWithTitle:@"打开失败"
                   withMessage:@"相册打开失败。设备不支持访问相册，请在设置->"
                               @"隐私->照片中进行设置！"];
  }
}

#pragma mark ===========添加提示框===========
//提示框alert
- (void)showAlertViewWithTitle:(NSString *)aTitle
                   withMessage:(NSString *)aMessage {
  [self.eventSubject sendNext:@(ScannerViewModelTypeStop)];
    
    [self.eventSubject sendNext:@(ScannerViewModelTypeStop)];


  UIAlertController *alert = [UIAlertController
      alertControllerWithTitle:aTitle
                       message:[NSString stringWithFormat:@"%@", aMessage]
                preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction
                       actionWithTitle:@"tishi"
                                 style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *_Nonnull action) {

                                 [self.eventSubject
                                     sendNext:@(ScannerViewModelTypeStart)];
                                   [self.eventSubject sendNext:@(ScannerViewModelTypeStart)];
                               }]];
  [self.View presentViewController:alert
                          animated:true
                        completion:^{

                        }];
}

#pragma mark - 打开照片

#pragma mark - 扫描二维码

#pragma mark - 获取二维码

#pragma mark - 生成二维码

#pragma mark - 从照片读取二维码

#pragma mark - 所有按钮的触发事件
- (RACSubject *)btnSubject {
  if (!_btnSubject) {
    _btnSubject = [RACSubject subject];
    @weakify(self)
        //处理所有按钮的信号
        [_btnSubject subscribeNext:^(UIImageView *x) {
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
- (RACSubject *)eventSubject {
  if (!_eventSubject) {
    _eventSubject = [RACSubject subject];
      @weakify(self)
    [_eventSubject subscribeNext:^(id x) {
        @strongify(self)
      ScannerViewModelType type = [x integerValue];
      switch (type) {
        case ScannerViewModelTypeStart:  //开启扫描
          [self.session startRunning];
          [[CJJ_Tools sharedTools].animation isShopScanAnimation:YES];
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

#pragma mark -懒加载
//数据模型
- (ScannerModel *)model {
  if (!_model) {
    _model = [[ScannerModel alloc] init];
  }
  return _model;
}

//获取appDelegate
- (AppDelegate *)appDelegate {
  if (!_appDelegate) {
    _appDelegate = [UIApplication sharedApplication].delegate;
  }
  return _appDelegate;
}

// device
- (AVCaptureDevice *)device {
  if (_device == nil) {
    // AVMediaTypeVideo是打开相机
    // AVMediaTypeAudio是打开麦克风
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  }
  return _device;
}
// input
- (AVCaptureDeviceInput *)input {
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
- (AVCaptureMetadataOutput *)output {
  if (_output == nil) {
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
  }
  return _output;
}

- (void)dealloc {
  NSLog(@"%s", __func__);
}

// session
- (AVCaptureSession *)session {
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
- (AVCaptureVideoPreviewLayer *)preview {
  if (_preview == nil) {
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
  }
  return _preview;
}

@end
