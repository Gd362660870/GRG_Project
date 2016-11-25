//
//  DownloadViewModel.h
//  下载并预览Demo
//
//  Created by 陈家劲 on 16/10/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadViewModel : NSObject<UITableViewDataSource,UITableViewDelegate>

/**
 *  初始化
 *
 *  @param controller 控制器
 *
 *  @return 实例
 */
- (instancetype)initWithViewController:(id)controller;


/**
 *  更新下载文件
 */
-(void)updateDownload;
@end
