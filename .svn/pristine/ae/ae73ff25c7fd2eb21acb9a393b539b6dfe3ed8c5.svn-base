//
//  UIView+Progress.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/9/30.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "UIView+Progress.h"
#import <objc/runtime.h>
@implementation UIView (Progress)

-(void)startProgresView
{
    self.progres = 1;
//    for (int i = 0; i < 200; i++) {
        NSLog(@"%f",self.progres+100);
//    }
    
//    NSLog(@"%@",self.foregroundView);
    self.foregroundView = [[UIView alloc]init];
    NSLog(@"%@",self.foregroundView);
    NSLog(@"%@",self.foregroundView);
    
}

#pragma mark- 关联属性


-(void)setForegroundView:(UIView *)foregroundView
{
    UIView *_foregroundView = objc_getAssociatedObject(self, @selector(foregroundView));
    if ( _foregroundView) {
        NSLog(@"循环引用");
        return;
    }
    objc_setAssociatedObject(self, @selector(foregroundView), foregroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)foregroundView
{
    UIView *_foregroundView =objc_getAssociatedObject(self, @selector(foregroundView));
    NSLog(@"%@",_foregroundView);
    if (!_foregroundView) {
        _foregroundView = [[UIView alloc]initWithFrame:ScreenBounds];
        objc_setAssociatedObject(self, @selector(foregroundView), _foregroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _foregroundView;
    
}



//进度条
-(void)setProgres:(CGFloat)progres
{
    objc_setAssociatedObject(self, @selector(progres), @(progres), OBJC_ASSOCIATION_ASSIGN);
    
    
}
-(CGFloat)progres
{
    //关联Get方法
    return [objc_getAssociatedObject(self, @selector(progres))floatValue];
    
}





@end
