//
//  DownloadModel.m
//  下载并预览Demo
//
//  Created by 陈家劲 on 16/10/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import <MJExtension/MJExtension.h>
#import "DownloadModel.h"
#import "DownloadModelItem.h"
#import "LocalFileModelItem.h"
@interface DownloadModel ()<DownloadModelItemDelegate>
/**
 *  数据源集合
 */
@property(nonatomic, strong) NSMutableArray *datasArray;

/**
 *  下载中的数据源
 */
@property(nonatomic, strong) NSMutableArray *downloadArray;

/**
 *  已下载到本地的数据源
 */
@property(nonatomic, strong) NSMutableArray *localFileArray;

/**
 *  文件管理器
 */
@property(strong, nonatomic) NSFileManager *fileManager;

/**
 *  获取所有本地文件
 *
 *  @return 返回数组
 */
- (NSMutableArray *)getAllLocalFile;

/**
 *  更新下载完的本地文件 并且排序
 *
 *  @return 返回数据
 */
- (NSMutableArray *)updateDownloadLocalFile:(NSString *)fileName;

/**
 *  获取未下载完文件
 */
- (NSMutableArray *)getFilesNotDownloaded;

/**
 *  保存为下载完的文件到 FILE_DOWNLOAD_SAVE_DATA
 */
- (void)saveFileAsDownloaded:(NSMutableArray *)array;

@end

@implementation DownloadModel

+ (DownloadModel *)sharedCNetDownloadModel {
  static DownloadModel *model = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{

    model = [[super alloc] init];

  });

  return model;
}

#pragma mark - dealloc
- (void)dealloc {
  NSLog(@"%s", __func__);
}


#pragma mark -开始下载新的URL_STR
- (NSMutableArray *)downloadFileURL:(NSString *)url {
  //下载新的文件
   DownloadModelItem *item =
      [[DownloadModelItem alloc] initWithStartDownload:url];
  [item setDelegate:self];
    
//     int num = 0;
//    
//    for (DownloadModelItem *item2 in self.downloadArray) {
//        
//        for (int j = 0; j < self.downloadArray.count; j ++) {
//            DownloadModelItem *item_test = self.downloadArray[j];
//            if ([item.modelItem.fileName isEqualToString:item_test.modelItem.fileName]) {
//                item.modelItem.fileName = [item.modelItem.fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",item.modelItem.fileExtension] withString:[NSString stringWithFormat:@"(%d).%@",num ++,item.modelItem.fileExtension]];
//                break;
//            }
//            
//        }
//        
//    }
    
    
    
  [self.downloadArray addObject:item];
    
  //保存数据到saveFile
  [self saveFileAsDownloaded:self.downloadArray];

  return self.datasArray;
}

#pragma mark - 保存为下载完的文件
- (void)saveFileAsDownloaded:(NSMutableArray *)array {
 
    NSMutableArray *mAry1 = [NSMutableArray array];
    for (DownloadModelItem *item in array) {
      [mAry1 addObject:item.modelItem];
    }

    NSMutableArray *mAry = [model mj_keyValuesArrayWithObjectArray:mAry1];

    if ([mAry writeToFile:FILE_DOWNLOAD_SAVE_DATA atomically:YES]) {
      NSLog(@"%@", FILE_DOWNLOAD_SAVE_DATA);
      NSLog(@"保存成功");
    } else {
      NSLog(@"保存失败");
    }
  }


#pragma mark -获取未下载完文件
- (NSMutableArray *)getFilesNotDownloaded {
  NSMutableArray *mArray = [NSMutableArray array];
  //判断文件路径是否存在
  if ([self.fileManager fileExistsAtPath:FILE_DOWNLOAD_SAVE_DATA]) {
    //存在 读取路径里的内容 并且字典数组转模型数组
    NSArray *array =
        [model mj_objectArrayWithKeyValuesArray:
                   [NSArray arrayWithContentsOfFile:FILE_DOWNLOAD_SAVE_DATA]];

    for (model *mo in array) {
      DownloadModelItem *modelItem = [[DownloadModelItem alloc] init];
      modelItem.modelItem = mo;
        modelItem.delegate = self;
      modelItem.modelItem.modelType = FileStatusTypeStop;
        modelItem.modelItem.fileNewOrOld = FileTypeEndOld;
      [mArray addObject:modelItem];
    }
  }

  return mArray;
}

#pragma mark -获取所有本地文件
- (NSMutableArray *)getAllLocalFile {
  //判断是否有这个目录
  [self.localFileArray removeAllObjects];
  if ([self.fileManager fileExistsAtPath:FILE_My_PAHT]) {
    NSError *error;
    // fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList =
        [self.fileManager contentsOfDirectoryAtPath:FILE_My_PAHT error:&error];

    if (error) {
      NSLog(@"%s\n%@", __func__, error);
    } else {
      for (NSString *file in fileList) {
          //.DS_Store这个是系统的文件
          if (![file isEqualToString:@".DS_Store"]) {
              LocalFileModelItem *item =
              [[LocalFileModelItem alloc] initWithFileName:file];
              [self.localFileArray addObject:item];

          }

             }
    }
  }

  return self.localFileArray;
}

#pragma mark - 更新下载完的本地文件
- (NSMutableArray *)updateDownloadLocalFile:(NSString *)fileName {
  NSError *error;
  NSArray *fileList =
      [self.fileManager contentsOfDirectoryAtPath:FILE_My_PAHT error:&error];

  if (error) {
    NSLog(@"%s\n%@", __func__, error);
  } else {
    for (NSString *file in fileList) {
      if ([file isEqualToString:fileName]) {
        LocalFileModelItem *item =
            [[LocalFileModelItem alloc] initWithFileName:file];
        [self.localFileArray addObject:item];
      }
    }
  }
  return self.localFileArray;
}

#pragma mark -更新文件
- (NSMutableArray *)updateFile {
  self.downloadArray = [self getFilesNotDownloaded];

  [self getAllLocalFile];

  self.datasArray = [NSMutableArray
      arrayWithObjects:self.downloadArray, self.localFileArray, nil];

  return self.datasArray;
}

#pragma mark -删除文件
- (NSMutableArray *)deleteFile:(NSIndexPath *)indexPath {
  id item = self.datasArray[indexPath.section][indexPath.row];

  if ([item isKindOfClass:[DownloadModelItem class]]) {
    NSLog(@"下载类");
    //取消下载

    DownloadModelItem *downloadItem = self.downloadArray[indexPath.row];

    [downloadItem.subjectDownloadStatus sendNext:DownloadStatusCancel];

    //删除该数组索引的对象
    [self.downloadArray removeObjectAtIndex:indexPath.row];

    [self saveFileAsDownloaded:self.downloadArray];
  } else if ([item isKindOfClass:[LocalFileModelItem class]]) {
    LocalFileModelItem *modelItem = item;
    NSLog(@"本地类");
    
      NSError *error = nil;
      [self.fileManager removeItemAtPath:modelItem.filePath error:&error];
      if (error) {
        NSLog(@"%@", error);
      }else
      {
          NSLog(@"删除成功");
      }
      
        [self.localFileArray removeObjectAtIndex:indexPath.row];
      
    }

  [self.subjectReloadData sendNext:@{
    @"delete" : indexPath,
    @"dataArray" : self.datasArray
  }];
  return self.datasArray;
}

#pragma mark -删除所有本地文件
- (NSMutableArray *)deleteAllFile {
  for (LocalFileModelItem *item in self.localFileArray) {
    NSError *error = nil;
    [self.fileManager removeItemAtPath:item.filePath error:&error];
    if (error) {
      NSLog(@"删除%@文件出错", item.fileName);
    } else {
      NSLog(@"删除%@文件成功", item.fileName);
    }
  }

  //更新dataArray
  self.datasArray = [self updateFile];

  return self.datasArray;
}

#pragma mark - DownloadModelItemDelegate
/**
 *  下载结束
 */
- (void)downloadEnd:(DownloadModelItem *)item {
  dispatch_queue_t queue = dispatch_get_main_queue();

  dispatch_async(queue, ^{

    int i = 0;
    //设置 删除和插入 索引路径
    NSIndexPath *deleteIndexPath = nil;

    for (DownloadModelItem *modelItem in self.downloadArray) {
      if (modelItem == item) {
        [modelItem.subjectDownloadStatus sendNext:@(DownloadStatusCancel)];
        [self.downloadArray removeObjectAtIndex:i];
        deleteIndexPath = [NSIndexPath indexPathForRow:i inSection:0];

        //保存
        [self saveFileAsDownloaded:self.downloadArray];

        //发送更新信号

        //创建一个串行多线程

        [self.subjectReloadData sendNext:@{

          @"delete" : deleteIndexPath,

          @"dataArray" : self.datasArray
        }];
          
        break;
      }
      i++;
    }

    NSIndexPath *insertIndexPath = nil;
    //更新数据源
    [self updateDownloadLocalFile:item.modelItem.fileName];

    insertIndexPath =
        [NSIndexPath indexPathForRow:self.localFileArray.count - 1 inSection:1];
    [self.subjectReloadData sendNext:@{
      @"insert" : insertIndexPath,
      @"dataArray" : self.datasArray
    }];

  });
}
/**
 *  下载开始
 */
- (void)downloadStart:(DownloadModelItem *)item {
}

/**
 *  下载暂停
 */
- (void)downloadPause:(DownloadModelItem *)item {
}

/**
 *  下载进度
 */
- (void)downloadProgress:(DownloadModelItem *)item {
}

#pragma mark - 懒加载
- (NSMutableArray *)datasArray {
  if (!_datasArray) {
    _datasArray = [NSMutableArray array];
  }
  return _datasArray;
}

- (NSMutableArray *)downloadArray {
  if (!_downloadArray) {
    _downloadArray = [NSMutableArray array];
  }
  return _downloadArray;
}

- (NSMutableArray *)localFileArray {
  if (!_localFileArray) {
    _localFileArray = [NSMutableArray array];
  }
  return _localFileArray;
}

- (NSFileManager *)fileManager {
  if (!_fileManager) {
    _fileManager = [NSFileManager defaultManager];
  }
  return _fileManager;
}

- (RACSubject *)subjectReloadData {
  if (!_subjectReloadData) {
    _subjectReloadData = [RACSubject subject];
  }
  return _subjectReloadData;
}

@end
