//
//  DownloadViewController.h
//  下载并预览Demo
//
//  Created by 陈家劲 on 16/10/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *DownloadCellID = @"DownloadTableViewCell";

@interface DownloadViewController : UIViewController


//TableView
@property (nonatomic,strong)UITableView *tableView;

/**
 *  初始化并接受下载URL
 *
 *  @param URL 下载路径
 *
 *  @return 返回一个实例
 */
-(instancetype)initWithDownloadURL:(NSString *)URL;

/**
 *  下载URL
 *
 *  @param url 下载路径
 */
- (void)downloadURL:(NSString *)url;

@end
