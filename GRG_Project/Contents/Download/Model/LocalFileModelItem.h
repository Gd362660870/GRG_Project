//
//  Local file Local file LocalFileModelItem.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/31.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LocalFileModelItem : NSObject




/**
 *  文件名字
 */
@property (nonatomic,strong)NSString *fileName;

/**
 *  文件后缀名
 */
@property (nonatomic,strong)NSString *fileExtension;
/**
 *  文件类型
 */
@property (nonatomic,assign)FileType fileType;
/**
 *  文件路径
 */
@property (nonatomic,strong)NSString *filePath;

/**
 *  文件URL
 */
@property (nonatomic,strong)NSURL *filePath_URL;
/**
 *  文件大小
 */
@property (nonatomic,assign)CGFloat file_Size;
/**
 *  文件图片
 */
@property (nonatomic,strong)NSString *fileTypeImageStr;

/**
 *  文件创建日期
 */
@property (nonatomic,strong)NSString *fileDate;

/**
 *  初始化 获得数据
 */
- (instancetype)initWithFileName:(NSString *)fileName;

@end
