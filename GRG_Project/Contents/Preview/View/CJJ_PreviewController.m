//
//  CJJ_PreviewController.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/11/15.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "CJJ_PreviewController.h"
#import <QuickLook/QuickLook.h>
#import "CJJ_PreviewViewModel.h"
@interface CJJ_PreviewController ()

/**
 *  预览控制器
 */
@property (nonatomic,strong)QLPreviewController *previewC;
/**
 *  视图模型
 */
@property (nonatomic,strong)CJJ_PreviewViewModel *viewModel;

@end

@implementation CJJ_PreviewController

#pragma mark- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.previewC.view];
    
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark -私有方法

#pragma mark -公共方法


#pragma mark -懒加载

-(QLPreviewController *)previewC
{
    if (!_previewC) {
        _previewC = [[QLPreviewController alloc]init];
        [_previewC.view setFrame:self.view.frame];
        [_previewC setDelegate:self.viewModel];
        [_previewC setDataSource:self.viewModel];
    }
    return _previewC;
}

-(CJJ_PreviewViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[CJJ_PreviewViewModel alloc]init];
        _viewModel.filePath_URL = self.filePath_URL;
    }
    return _viewModel;
}



@end
