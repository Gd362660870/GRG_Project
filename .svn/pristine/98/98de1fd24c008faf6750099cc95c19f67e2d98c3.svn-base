//
//  DownloadModelItem.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/27.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "DownloadModelItem.h"

#define MB_SAVE_NUM 2

@interface DownloadModelItem ()<NSURLSessionTaskDelegate>
@property(strong, nonatomic) NSFileManager *fileManager;  //文件管理器
@property(nonatomic, strong) NSData *resumeData;          //记录上次数据
@property (nonatomic,strong)NSURLSessionDownloadTask *task;//下载任务
@property (strong, nonatomic) NSURLSession *session;//下载设置
@property (strong,nonatomic) NSTimer *timer; //定时器
@property (nonatomic,assign) CGFloat downloadSpeedTotal;//小计下载速度



/**
 *  暂停下载
 */
- (void)pause;

/**
 *  恢复下载
 */
- (void)resume;

/**
 *  取消下载
 */
- (void)cancel;

/**
 *  持续保存  <1M时 自动保存一次
 */
- (void)lastSave:(CGFloat)bytesWritten;

/**
 *  获取下载信息
 */
- (void)getDownloadInfo:(NSString *)url;

/**
 *  判断本地文件是否有同名
 */
- (BOOL)isLocalFIleName;

/**
 *  下载速度
 */
-(void)downloadSpeed;
@end

@implementation DownloadModelItem

#pragma mark - 接口方法

#pragma init

- (instancetype)initWithStartDownload:(NSString *)url {
  self = [super init];
  if (self) {
    [self startDownload:url];
  }
  return self;
}

#pragma mark 开始下载
- (void)startDownload:(NSString *)url {
    //设置下载新值
    self.modelItem.fileNewOrOld = FileTypeEndNew;
  //获取下载信息
  [self getDownloadInfo:url];

  self.task = [self.session
      downloadTaskWithRequest:
          [NSURLRequest requestWithURL:[NSURL URLWithString:self.modelItem.fileURL]]];
    self.modelItem.modelType = FileStatusTypeStart;
  //启动下载
    [self.task resume];
    //定时器开始
    [self.timer setFireDate:[NSDate distantPast]];
}

#pragma mark 获取下载信息
- (void)getDownloadInfo:(NSString *)url;
{
  self.modelItem.fileExtension = [url pathExtension];          //获取文件扩展名
  self.modelItem.fileURL = url;                                //获取文件下载路径
  self.modelItem.fileName = [self.modelItem.fileURL lastPathComponent];  //获取文件名

  //获取数据保存目录路径
  self.modelItem.fileSaveListPaht = FILE_My_PAHT;

  //判断路径是否存在
  if (![self.fileManager fileExistsAtPath:self.modelItem.fileSaveListPaht]) {
    //不存在 创建文件夹
    [self.fileManager createDirectoryAtPath:FILE_My_PAHT
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:nil];
  }
  //获取数据保存文件路径
  self.modelItem.dataPath = [FILE_CACHES_PAHT
      stringByAppendingString:[NSString
                                  stringWithFormat:@"/%@", self.modelItem.fileName]];

  //判断本地文件是否有同名
//  [self isLocalFIleName];

#warning FILE____TYPE
//    self.fileType = nil;
#warning FILE____IMAGW___STR
  //    self.fileTypeImageStr = nil;
}

#pragma mark - 私有方法

#pragma mark 暂停下载
- (void)pause {
  @weakify(self)
      [self.task cancelByProducingResumeData:^(NSData *_Nullable resumeData) {
        if (resumeData) {
          @strongify(self) if (resumeData) {
            [resumeData writeToFile:self.modelItem.dataPath atomically:YES];
            self.task = nil;
          }
        }

      }];
    //delegate  ----- 暂停下载
    self.modelItem.modelType = FileStatusTypeStop;
    [self.delegate downloadPause:self];
    //定时器暂定
    [self.timer setFireDate:[NSDate distantFuture]];
    
}

#pragma mark 恢复下载
- (void)resume {
    
    
    [self getDownloadInfo:self.modelItem.fileURL];
    
  //判断路径是否存在
  if ([self.fileManager fileExistsAtPath:self.modelItem.dataPath]) {
    //存在 在本地读取
    self.task = [self.session downloadTaskWithResumeData:[NSData dataWithContentsOfFile:self.modelItem.dataPath]];
  } else {
    //不存在 重新网络下载
    self.task = [self.session
        downloadTaskWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:self.modelItem.fileURL]]];
  }
  [self.task resume];
    
    // delegate ----  继续下载
    self.modelItem.modelType = FileStatusTypeStart;
    [self.delegate downloadStart:self];
    //定时器开始
    [self.timer setFireDate:[NSDate distantPast]];
}

#pragma mark 取消下载
- (void)cancel {
  //所有属性清空
    [self.task suspend];
    self.delegate = nil;
    [self.session invalidateAndCancel];
    self.session = nil;
    //定时器销毁
    [self.timer invalidate];
  NSError *error = nil;
    
  //判断路径是否存在
  if ([self.fileManager fileExistsAtPath:self.modelItem.dataPath]) {
    //存在 删除文件
    [self.fileManager removeItemAtPath:self.modelItem.dataPath error:&error];
  }

  if (error) {
    NSLog(@"取消下载出错---------%@", error);
  }
    
    
}

#pragma mark 持续保存  <？M时 自动保存一次
- (void)lastSave:(CGFloat)bytesWritten {
  static CGFloat MB = 0;
  MB += bytesWritten / 1024.f / 1024.f;
  if (MB > MB_SAVE_NUM) {
    MB = 0;
    NSLog(@"下载累计大于%d保存一次", MB_SAVE_NUM);
    @weakify(self)

        //创建一个串行多线程
        dispatch_queue_t queue =
            dispatch_queue_create("FILE_SAVE", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{

      [self.task cancelByProducingResumeData:^(NSData *_Nullable resumeData) {
        if (resumeData) {
          @strongify(self);
            
            if ([resumeData writeToFile:self.modelItem.dataPath atomically:YES]) {
                NSData *data = [NSData dataWithContentsOfFile:self.modelItem.dataPath];
                self.task = [self.session downloadTaskWithResumeData:data];
                [self.task resume];
            }else
            {
                self.task = [self.session downloadTaskWithResumeData:resumeData];
                [self.task resume];
            }
          
        }

      }];

    });
  }
}


#pragma mark 下载速度
-(void)downloadSpeed
{

    self.modelItem.downloadSpeed = self.downloadSpeedTotal;
    self.downloadSpeedTotal = 0.f;
   
}

#pragma mark 判断自动生成同名
- (BOOL)isLocalFIleName {

  NSString *name = [self.modelItem.fileName
      stringByReplacingCharactersInRange:
          [self.modelItem.fileName
              rangeOfString:[NSString
                                stringWithFormat:@".%@", self.modelItem.fileExtension]]
                              withString:@""];

  //获取保存文件的路径
  self.modelItem.fileSavePath = [NSString
      stringWithFormat:@"%@/%@", self.modelItem.fileSaveListPaht, self.modelItem.fileName];

    switch (self.modelItem.fileNewOrOld) {
        case FileTypeEndNew:
        {
            int i = 1;
            while ([self.fileManager fileExistsAtPath:self.modelItem.fileSavePath]) {
                self.modelItem.fileName = [name
                                           stringByAppendingString:[NSString stringWithFormat:@"(%d).%@", i++,
                                                                    self.modelItem.fileExtension]];
                self.modelItem.fileSavePath = [self.modelItem.fileSaveListPaht
                                               stringByAppendingString:[NSString
                                                                        stringWithFormat:@"/%@", self.modelItem.fileName]];
            }

        }
            break;
        case FileTypeEndOld:
        {
            
        }
            break;
            
        default:
            break;
    }
 
  return YES;
}

#pragma mark - NSURLSessionTaskDelegate

#pragma mark 下载进度
/**
 *  写入数据
 *  @param session
 *  @param downloadTask              当前下载任务
 *  @param bytesWritten              当前这次写入数据的大小
 *  @param totalBytesWritten         已经写入数据的大小
 *  @param totalBytesExpectedToWrite 预计写入数据的总大小
 */
- (void)URLSession:(NSURLSession *)session
                 downloadTask:(NSURLSessionDownloadTask *)downloadTask
                 didWriteData:(int64_t)bytesWritten
            totalBytesWritten:(int64_t)totalBytesWritten
    totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
  [self lastSave:bytesWritten];
  self.modelItem.file_Size = totalBytesExpectedToWrite / 1024.f / 1024.f;
  self.modelItem.progress = (CGFloat)totalBytesWritten / totalBytesExpectedToWrite;
    self.downloadSpeedTotal += bytesWritten / 1024.f;
    
    //delegate ----- 下载进度
    [self.delegate downloadProgress:self];
}

#pragma mark 下载完毕
- (void)URLSession:(NSURLSession *)session
                 downloadTask:(NSURLSessionDownloadTask *)downloadTask
    didFinishDownloadingToURL:(NSURL *)location {
    
    
    
    [self isLocalFIleName];
  NSError *error;
  //移动文件
  [self.fileManager moveItemAtURL:location
                            toURL:[NSURL fileURLWithPath:self.modelItem.fileSavePath]
                            error:&error];
  if (error) {
    NSLog(@"/移动文件失败%@", error);
    error = nil;
  }


  //删除文件
  [self.fileManager removeItemAtPath:self.modelItem.dataPath error:&error];
  if (error) {
    NSLog(@"删除文件失败%@", error);
    error = nil;
  }

    //delegate ----- 下载结束
    [self.delegate downloadEnd:self];
    
}

#pragma mark 继续下载时已经下载的数据和总数据大小

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
  NSLog(@"%s", __func__);
}
#pragma mark - dealloc
- (void)dealloc {
  NSLog(@"%s", __func__);
}

#pragma mark - 懒加载

- (NSFileManager *)fileManager {
  if (!_fileManager) {
    _fileManager = [NSFileManager defaultManager];
  }
  return _fileManager;
}

-(NSURLSession *)session
{
    if (!_session) {
        _session =
        [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration
                                                defaultSessionConfiguration]
                                      delegate:self
                                 delegateQueue:0];
    }
    return _session;
}

- (RACSubject *)subjectDownloadStatus {
  if (!_subjectDownloadStatus) {
    _subjectDownloadStatus = [RACSubject subject];

    @weakify(self)[_subjectDownloadStatus subscribeNext:^(id x) {
      @strongify(self) DownloadStatus status = [x integerValue];
      switch (status) {
        case DownloadStatusCancel:  //取消下载
          [self cancel];
          break;

        case DownloadStatusePause:  //暂停下载
          [self pause];
          break;

        case DownloadStatusStart:  //开始下载
          [self resume];
          break;

        default:
          break;
      }
    }];
  }
  return _subjectDownloadStatus;
}

-(model *)modelItem
{
    if (!_modelItem) {
        _modelItem = [[model alloc]init];
    }
    return _modelItem;
}



-(NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(downloadSpeed) userInfo:nil repeats:YES];

        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

    }
    return _timer;
}



@end

@implementation model



@end
