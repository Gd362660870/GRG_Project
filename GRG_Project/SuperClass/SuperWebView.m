//
//  SuperWebView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "SuperWebView.h"

@implementation SuperWebView
-(instancetype)initWithFrame:(CGRect)frame
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


@end
