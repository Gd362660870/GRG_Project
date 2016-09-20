//
//  AppView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "AppView.h"
#import "AppViewModel.h"

@interface AppView ()
@property (nonatomic,strong)AppViewModel *viewModel;
@property (nonatomic,strong)SuperWebView *webView;
@end

@implementation AppView

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //添加视图
    [self addViews];
 
    //适配
    [self defineLayout];
  
    //关联
    [self bindWithViewModel];
}

#pragma mark - 添加视图
- (void)addViews {
    
}

#pragma mark - 适配
- (void)defineLayout {
}

#pragma mark - 关联
- (void)bindWithViewModel {
    
}

#pragma mark- 懒加载
-(AppViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AppViewModel alloc]initWithViewController:self];
    }
    return _viewModel;
}


@end
