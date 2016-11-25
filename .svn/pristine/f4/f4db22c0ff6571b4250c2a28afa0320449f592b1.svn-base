//
//  UIProgressView+CJJ.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/9/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "UIProgressView+CJJ.h"

@implementation UIProgressView (CJJ)

//-(void)setProgress:(float)progress
//{
//    NSLog(@"%f",progress);
////    [self setProgress:progress animated:NO];
//}


-(void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    NSLog(@"layer_w----> %f  layer_h ------> %f",layer.bounds.size.width,layer.bounds.size.height);
}
-(void)setHidden:(BOOL)hidden
{
    NSLog(@"%hhd" ,hidden);
    
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animation];
    basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    int a = !hidden;
    basicAnimation.toValue= @(a);
    [self pop_addAnimation:basicAnimation forKey:@"aaaa"];
    
    if (hidden == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo([self superview]).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.height.mas_equalTo(100);
        }];
    }else
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo([self superview]).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.height.mas_equalTo(0);
        }];
    }
    
}
@end
