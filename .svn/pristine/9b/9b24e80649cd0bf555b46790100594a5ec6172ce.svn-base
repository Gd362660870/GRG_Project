//
//  MainTabBar.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/13.
//  Copyright © 2016年 陈家劲. All rights reserved.
//dddd	

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,MainTabBarType){
    MainTabBarTypeMessages = 0,
    MainTabBarTypeNews,
    MainTabBarTypeAPP,
    MainTabBarTypeFind,
    MainTabBarTypeMe,

};
@interface MainTabBar : UIView

/**
 *  点击手势信号
 */
@property (nonatomic,strong)RACSubject *tapSubject;

/**
 *  隐藏
 */
-(void)hideTabBar;

/**
 *  显示
 */
-(void)showTabBar;

/**
 *  高亮显示某个按钮,另外其余按钮则非选择状态
 *
 *  @param number 100～105 数值
 */
-(void)mainTabBarSelectedTagNumber:(NSUInteger)tag;

@end
