//
//  SuperWKWebView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/9/8.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "SuperWKWebView.h"

@implementation SuperWKWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置滚动视图内容距离
        [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, TabBar_Height_1, 0)];
        
        //滚动指标插图从滚动视图边缘的距离。
        [self.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, TabBar_Height_1, 0)];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration
{
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        //设置滚动视图内容距离
        [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, TabBar_Height_1, 0)];
        
        //滚动指标插图从滚动视图边缘的距离。
        [self.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, TabBar_Height_1, 0)];
    }
    return self;
}

@end
