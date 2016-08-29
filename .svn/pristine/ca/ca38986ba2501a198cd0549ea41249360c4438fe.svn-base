//
//  AppDelegate.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "AppDelegate.h"
#import "AppView.h"
#import "FindView.h"
#import "MeView.h"
#import "MessagesView.h"
#import "NewsView.h"
#import "SuperNavigationController.h"

@interface AppDelegate ()
@property(nonatomic, strong) UITabBarController *tabBarC;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
  //确定登陆
  [self determineLanding];
  return YES;
}
#pragma mark -确定登陆
- (void)determineLanding {
  //消息
  NewsView *newsVC = [[NewsView alloc] init];
  SuperNavigationController *newsNVC =
      [[SuperNavigationController alloc] initWithRootViewController:newsVC];
    [newsNVC.view setBackgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]];
  newsVC.title = @"消息";

  [newsVC.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
  [newsVC.tabBarItem setImage:[UIImage imageNamed:@""]];
    
    
  //通讯录
  MessagesView *messagesVC = [[MessagesView alloc] init];
    [messagesVC.view setBackgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]];
  SuperNavigationController *messagesNVC =
    [[SuperNavigationController alloc] initWithRootViewController:messagesVC];
    messagesVC.title = @"通讯录";
  [messagesVC.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
  [messagesVC.tabBarItem setImage:[UIImage imageNamed:@""]];
 
    //应用
  AppView *appVC = [[AppView alloc] init];
    [appVC.view setBackgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]];
    appVC.title = @"应用";
  [appVC.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
  [appVC.tabBarItem setImage:[UIImage imageNamed:@""]];
    SuperNavigationController *AppNVC =
    [[SuperNavigationController alloc] initWithRootViewController:appVC];
 
  //发现
  FindView *findVC = [[FindView alloc] init];
    [findVC.view setBackgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]];
    findVC.title = @"发现";
  SuperNavigationController *findNVC =
      [[SuperNavigationController alloc] initWithRootViewController:findVC];
  [findVC.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
  [findVC.tabBarItem setImage:[UIImage imageNamed:@""]];

  //我
  MeView *meVC = [[MeView alloc] init];
    [meVC.view setBackgroundColor:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]];
  SuperNavigationController *meNVC =
      [[SuperNavigationController alloc] initWithRootViewController:meVC];
    meVC.title = @"我";
  [meVC.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
  [meVC.tabBarItem setImage:[UIImage imageNamed:@""]];
    
    self.tabBarC = [[UITabBarController alloc]init];
    [self.tabBarC setViewControllers:@[newsNVC,messagesNVC,AppNVC,findNVC,meNVC] animated:YES];
    
    self.window = [[UIWindow alloc]initWithFrame:SCREEN_BOUNDS];
    
    [self.window setRootViewController:self.tabBarC];
    [self.window makeKeyAndVisible];
    
    //
    [[CJJ_Tools sharedTools]setTabBarItemWithTitleSize:12 andFoneName:@"Marion-Italic" withSelectColor:[UIColor redColor] withUnSelectColor:[UIColor grayColor]];


}
#pragma mark -AppDelegate声明周期
//程序失去焦点的时候调用（不能跟用户进行交互了）
- (void)applicationWillResignActive:(UIApplication *)application {
  NSLog(@"applicationWillResignActive-失去焦点");
}

//当应用程序进入后台的时候调用（点击HOME键）
- (void)applicationDidEnterBackground:(UIApplication *)application {
  NSLog(@"applicationDidEnterBackground-进入后台");
}

//当应用程序进入前台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
  NSLog(@"applicationWillEnterForeground-进入前台");
}

//当应用程序获取焦点的时候调用
- (void)applicationDidBecomeActive:(UIApplication *)application {
  NSLog(@"applicationDidBecomeActive-获取焦点");
}

//程序在某些情况下被终结时会调用这个方法
- (void)applicationWillTerminate:(UIApplication *)application {
  NSLog(@"applicationWillTerminate-被关闭");
}

#pragma mark -懒加载


@end
