//
//  DownloadTableViewCell.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadModelItem.h"

typedef void(^MyBlock)(UIButton *);
@interface DownloadTableViewCell : UITableViewCell

@property (nonatomic,strong)RACSubject *subjectButton;

/**
 *  按钮表面
 */
@property (strong, nonatomic)  UIButton *btnFace;

/**
 *  本地文件路径
 */
@property (nonatomic,strong)NSURL *filePath_URL;

/**
 *  本地文件名字
 */
@property (nonatomic,strong)NSString *fileName;

/**
 *  一个下载模型
 */
@property (nonatomic,strong)DownloadModelItem *downloadModel;

//@property (nonatomic,weak)

@property (nonatomic,strong)MyBlock block;


/**
 *  更新数据
 *
 *  @param item 数据源
 */
-(void)updateDataItem:(id)item;
@end
