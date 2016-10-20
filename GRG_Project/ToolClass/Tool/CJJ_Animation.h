//
//  CJJ_Animation.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/12.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJJ_Animation : NSObject
#pragma mark- 二维码动画属性
@property (nonatomic,strong)POPBasicAnimation *popBasiLine;
@property (nonatomic,strong)POPSpringAnimation *popSpringLine;

#pragma mark- 二维码动画控制方法
/**
 *  是否开始二维码动画
 */
-(void)isShopScanAnimation:(BOOL)isBOOL;
@end
