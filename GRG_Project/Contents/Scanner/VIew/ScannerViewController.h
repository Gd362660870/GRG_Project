//
//  ScannerViewController.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/10.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScannerViewController.h"
#import "ScannerViewModel.h"


@interface ScannerViewController : UIViewController
@property (nonatomic,strong)ScannerViewModel *viewModel;

//扫描框
@property (nonatomic,strong)UIImageView *imageView;

//扫描线
@property (nonatomic,retain)UIImageView *line;


//设置背景摄像图的颜色<默认灰色>

//设置扫描线的样式（默认蓝色）

@end
