//
//  DownloadModel.h
//  下载并预览Demo
//
//  Created by 陈家劲 on 16/10/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadModelItem.h"

@interface DownloadModel : NSObject


/**
 *  更新数据的信号
 */
@property (nonatomic,strong)RACSubject *subjectReloadData;

/**
 *  单例初始化
 */
+(DownloadModel *)sharedCNetDownloadModel;


/**
 *  获取下载和本地文件
 *
 *  @param url url
 *
 *  @return 一个数组@【正在下载数组,本地文件数组】
 */
-(NSMutableArray *)downloadFileURL:(NSString *)url;


/**
 *  获取更新下载以及本地文件
 *
 *  @return 一个数组@【正在下载数组,本地文件数组】
 */
-(NSMutableArray *)updateFile;



/**
 *  删除文件
 *
 *  @param indexPath 一个索引路径
 *
 *  @return 一个数组@【正在下载数组,本地文件数组】
 */
-(NSMutableArray *)deleteFile:(NSIndexPath *)indexPath;


/**
 *  删除所有本地文件
 */
- (NSMutableArray *)deleteAllFile;




@end
