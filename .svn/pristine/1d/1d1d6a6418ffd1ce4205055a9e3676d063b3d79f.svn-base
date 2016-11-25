//
//  Local file Local file LocalFileModelItem.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/31.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "LocalFileModelItem.h"

@interface LocalFileModelItem ()

/**
 *  文件管理
 */
@property(nonatomic, strong) NSFileManager *fileManager;

@property(nonatomic, strong) NSArray *fileTypeArray;

@end

@implementation LocalFileModelItem

#pragma mark - 初始化
- (instancetype)initWithFileName:(NSString *)fileName {
  self = [super init];
  if (self) {
    //文件后缀名
    self.fileExtension = [fileName pathExtension];

    //文件名字
    self.fileName = fileName;

    //文件类型
      for (NSDictionary *dict in self.fileTypeArray) {
          if ([dict[@"name"] isEqualToString:self.fileExtension]) {
              self.fileType = [dict[@"type"]integerValue];
          }
      }

    //文件路径
    self.filePath = [FILE_My_PAHT
        stringByAppendingString:[NSString stringWithFormat:@"/%@", fileName]];
      
      //文件路径URL
      self.filePath_URL = [NSURL fileURLWithPath:self.filePath];
      
      
    //文件大小
    NSError *error;
    self.file_Size = [[self.fileManager attributesOfItemAtPath:self.filePath
                                                        error:&error] fileSize] /1024.f/1024.f;
      
    //获取文件信息
    NSDictionary *dict =
        [self.fileManager attributesOfItemAtPath:self.filePath error:&error];
      
      NSDate *date = dict[@"NSFileCreationDate"];

      NSRange range = [date.description rangeOfString:@" "];
      self.fileDate = [date.description substringToIndex:range.location];
      
      

#warning fileImage
    //文件图片
    //        switch (self.fileType) {
    //            case FileTypeBMP:
    //
    //                break;
    //
    //            case FileTypeDoc:
    //
    //                break;
    //
    //            case FileTypeDocx:
    //
    //                break;
    //
    //            case FileTypeDWG:
    //
    //                break;
    //
    //            case FileTypeEXE:
    //
    //                break;
    //
    //            case FileTypeJPEG:
    //
    //                break;
    //
    //            case FileTypeJPG:
    //
    //                break;
    //
    //            case FileTypePDF:
    //
    //                break;
    //
    //            case FileTypePNG:
    //
    //                break;
    //
    //            case FileTypePPT:
    //
    //                break;
    //
    //            case FileTypeRAR:
    //
    //                break;
    //
    //            case FileTypeTxt:
    //
    //                break;
    //
    //
    //            default:
    //                break;
    //        }
  }
  return self;
}

#pragma dealloc
-(void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark - 懒加载
- (NSFileManager *)fileManager {
  if (!_fileManager) {
    _fileManager = [NSFileManager defaultManager];
  }
  return _fileManager;
}

- (NSArray *)fileTypeArray {
  if (!_fileTypeArray) {
    _fileTypeArray = @[
      @{
        @"name" : @"jpg",
        @"type" : @(FileTypeJPG)
      },
      @{
        @"name" : @"png",
        @"type" : @(FileTypePNG)
      },
      @{
        @"name" : @"jpeg",
        @"type" : @(FileTypeJPEG)
      },
      @{
        @"name" : @"pdf",
        @"type" : @(FileTypePDF)
      },
      @{
        @"name" : @"docx",
        @"type" : @(FileTypeDocx)
      },
      @{
        @"name" : @"doc",
        @"type" : @(FileTypeDoc)
      },
      @{
        @"name" : @"ppt",
        @"type" : @(FileTypePPT)
      },
      @{
        @"name" : @"txt",
        @"type" : @(FileTypeTxt)
      },
      @{
        @"name" : @"rar",
        @"type" : @(FileTypeRAR)
      },
      @{
        @"name" : @"dwg",
        @"type" : @(FileTypeDWG)
      },
      @{
        @"name" : @"exe",
        @"type" : @(FileTypeEXE)
      },
      @{
        @"name" : @"bmp",
        @"type" : @(FileTypeBMP)
      }
    ];
  }
  return _fileTypeArray;
}
@end
