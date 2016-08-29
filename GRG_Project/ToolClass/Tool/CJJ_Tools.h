//
//  CJJ_Tools.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJJ_Tools : NSObject

/**
 *  单例创建NetWork对象
 *
 */
+(CJJ_Tools *)sharedTools;


/**
 *  设置TabBarItem的各种状态下字体大小、颜色.
 *
 *  @param size          字体大小
 *  @param foneName      字体名字
 *  @param selectColor   选中后的颜色
 *  @param unselectColor 没选中的颜色
 */
- (void)setTabBarItemWithTitleSize:(CGFloat)size
                       andFoneName:(NSString *)foneName
                    withSelectColor:(UIColor *)selectColor
                    withUnSelectColor:(UIColor *)unselectColor;

@end
