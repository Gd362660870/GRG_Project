//
//  CJJ_Animation.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/12.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "CJJ_Animation.h"

@implementation CJJ_Animation


/**
 *  暂停二维码动画
 */
-(void)isShopScanAnimation:(BOOL)isBOOL
{
    self.popSpringLine.paused = isBOOL;
    self.popBasiLine.paused = isBOOL;
}


#pragma mark - 懒加载
-(POPBasicAnimation *)popBasiLine
{
    if (!_popBasiLine) {
        _popBasiLine = [POPBasicAnimation easeInEaseOutAnimation];
        _popBasiLine.property=[POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
        _popBasiLine.name = @"line"; //命名
        _popBasiLine.fromValue = @(10);//开始位置
        _popBasiLine.toValue = @(SCANNER_FRAME_WIDTH - 10);//结束
        _popBasiLine.duration = 1;//持续时间
        _popBasiLine.repeatForever = YES; //无限循环
        _popBasiLine.autoreverses = YES; //自动反向
        //    _popBasiLine = YES; //暂停
        
    }
    return _popBasiLine;
}

-(POPSpringAnimation *)popSpringLine
{
    if (!_popSpringLine) {
        _popSpringLine = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        _popSpringLine.toValue = [NSValue valueWithCGSize:CGSizeMake(0.8, 0.9)];
        _popSpringLine.velocity = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
        _popSpringLine.repeatForever = YES; //无限循环
        _popSpringLine.autoreverses = YES; //自动反向
    }
    return _popSpringLine;
}
@end
