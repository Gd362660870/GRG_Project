//
//  CJJ_Tools.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "CJJ_Tools.h"

@implementation CJJ_Tools

+(CJJ_Tools *)sharedTools
{
    static CJJ_Tools *tool = nil;
    if (tool == nil) {
        tool = [[super alloc]init];
    }
    return tool;
}


- (void)setTabBarItemWithTitleSize:(CGFloat)size
                       andFoneName:(NSString *)foneName
                   withSelectColor:(UIColor *)selectColor
                 withUnSelectColor:(UIColor *)unselectColor {
  //未选中字体颜色
  [[UITabBarItem appearance] setTitleTextAttributes:@{
    NSForegroundColorAttributeName : unselectColor,
    NSFontAttributeName : [UIFont fontWithName:foneName size:size]
  }
                                           forState:UIControlStateNormal];
  
  //    //选中字体颜色
  [[UITabBarItem appearance] setTitleTextAttributes:@{
    NSForegroundColorAttributeName : selectColor,
    NSFontAttributeName : [UIFont fontWithName:foneName size:size]
  }
                                           forState:UIControlStateSelected];
}
@end
