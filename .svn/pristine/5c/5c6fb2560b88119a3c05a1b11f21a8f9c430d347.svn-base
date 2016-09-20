//
//  LandingView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/29.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "LandingView.h"
#import "LandingViewModel.h"

@interface LandingView ()
@property (nonatomic,strong)LandingViewModel *viewModel;
@end

@implementation LandingView

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
    [self.view setBackgroundColor:[UIColor redColor]];
    //延迟操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.viewModel.appDelegate exitLanding];
    });
}

-(void)dealloc
{
    NSLog(@"%s",__func__ );
}

#pragma mark - 适配
- (void)defineLayout {
}

#pragma mark - 关联
- (void)bindWithViewModel {
    
}

#pragma mark- 懒加载
-(LandingViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[LandingViewModel alloc]initWithViewController:self];
    }
    return _viewModel;
}

@end
