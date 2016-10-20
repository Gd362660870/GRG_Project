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
#import "LandingView.h"
#import "MeView.h"
#import "MessagesView.h"
#import "NewsView.h"
#import "SuperNavigationController.h"
#import "MainViewC.h"

@interface AppDelegate ()
@property(nonatomic, strong) UITabBarController *tabBarC;
@property(nonatomic, strong) SuperNavigationController *landingNVC;
@property(nonatomic, strong) SuperNavigationController *findNVC;
@property (nonatomic,strong) SuperNavigationController *mainNVC;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //初始化用户模型
  self.userModel = [[UserModel alloc] init];

//    [self.userModel deleteCookie];
//  [self.userModel AddCookie];

#warning 测试新方案
    //加载main视图
    [self setMainView];
  //登陆视图
//  [self setLandingView];
    
    //确定登陆
//    [self determineLanding];
    
#warning 测试FindView
//    [self setFindView];

    
  return YES;
}


#pragma mark - 加载main视图
-(void)setMainView
{
    self.window = [[UIWindow alloc] initWithFrame:ScreenBounds];
    [self.window setRootViewController:self.mainNVC];
    [self.window makeKeyAndVisible];
}
#pragma mark - 登陆视图
- (void)setLandingView {
  self.window = [[UIWindow alloc] initWithFrame:ScreenBounds];
  [self.window setRootViewController:self.landingNVC];
  [self.window makeKeyAndVisible];
}

#pragma mark - 测试二维码
- (void)setFindView {
    self.window = [[UIWindow alloc] initWithFrame:ScreenBounds];
    [self.window setRootViewController:self.findNVC];
    [self.window makeKeyAndVisible];
}

#pragma mark - 退出登陆
- (void)exitLanding {
  [self.window setRootViewController:self.tabBarC];
}

#pragma mark -确定登陆
- (void)determineLanding {
    
    
    [[CJJ_Tools sharedTools] setTabBarItemWithTitleSize:12 andFoneName:nil];
  self.window = [[UIWindow alloc] initWithFrame:ScreenBounds];

  [self.window setRootViewController:self.tabBarC];
  [self.window makeKeyAndVisible];

  
    
  
}
#pragma mark -AppDelegate声明周期

//程序失去焦点的时候调用（不能跟用户进行交互了）
- (void)applicationWillResignActive:(UIApplication *)application {
  NSLog(@"失去焦点");

  //创建一个并行多线程
  dispatch_queue_t queue =
      dispatch_queue_create("biaoQian", DISPATCH_QUEUE_CONCURRENT);

  dispatch_async(queue, ^{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(test)
                                                    userInfo:nil
                                                     repeats:YES];

    [timer setFireDate:[NSDate distantPast]];

  });
}
- (void)test {
  static int i = 0;
  NSLog(@"%d", i++);
}

//当应用程序进入后台的时候调用（点击HOME键）
- (void)applicationDidEnterBackground:(UIApplication *)application {
  NSLog(@"点击HOME键");
}

//当应用程序进入前台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
  NSLog(@"进入前台");
}

//当应用程序获取焦点的时候调用
- (void)applicationDidBecomeActive:(UIApplication *)application {
  [[NSHTTPCookieStorage sharedHTTPCookieStorage]
      setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
  NSLog(@"获取焦点");
  //延迟操作
}

//程序在某些情况下被终结时会调用这个方法
- (void)applicationWillTerminate:(UIApplication *)application {
  NSLog(@"被关闭");
}

#pragma mark -懒加载
- (UITabBarController *)tabBarC {
  if (!_tabBarC) {
    //消息
    NewsView *newsVC = [[NewsView alloc] init];
    SuperNavigationController *newsNVC =
        [[SuperNavigationController alloc] initWithRootViewController:newsVC];
    [newsNVC.view
        setBackgroundColor:[UIColor colorWithRed:arc4random() % 255 / 255.0
                                           green:arc4random() % 255 / 255.0
                                            blue:arc4random() % 255 / 255.0
                                           alpha:1]];
    newsVC.tabBarItem.title = @"消息";

    [newsVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon-1"]];
      [newsVC.tabBarItem setImage:[UIImage imageNamed:@"icon-1"]];

    //通讯录
    MessagesView *messagesVC = [[MessagesView alloc] init];
    [messagesVC.view
        setBackgroundColor:[UIColor colorWithRed:arc4random() % 255 / 255.0
                                           green:arc4random() % 255 / 255.0
                                            blue:arc4random() % 255 / 255.0
                                           alpha:1]];
    SuperNavigationController *messagesNVC = [[SuperNavigationController alloc]
        initWithRootViewController:messagesVC];
    messagesVC.tabBarItem.title = @"通讯录";
      [messagesVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon-2"]];
    [messagesVC.tabBarItem setImage:[UIImage imageNamed:@"icon-2"]];

    //应用
    AppView *appVC = [[AppView alloc] init];
    [appVC.view
        setBackgroundColor:[UIColor colorWithRed:arc4random() % 255 / 255.0
                                           green:arc4random() % 255 / 255.0
                                            blue:arc4random() % 255 / 255.0
                                           alpha:1]];
    appVC.tabBarItem.title = @"应用";
      [appVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon-3"]];
    [appVC.tabBarItem setImage:[UIImage imageNamed:@"icon-3"]];
    SuperNavigationController *AppNVC =
        [[SuperNavigationController alloc] initWithRootViewController:appVC];

    //发现
    FindView *findVC = [[FindView alloc] init];
    [findVC.view
        setBackgroundColor:[UIColor colorWithRed:arc4random() % 255 / 255.0
                                           green:arc4random() % 255 / 255.0
                                            blue:arc4random() % 255 / 255.0
                                           alpha:1]];
    findVC.tabBarItem.title = @"发现";
    SuperNavigationController *findNVC =
        [[SuperNavigationController alloc] initWithRootViewController:findVC];
    [findVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon-4"]];
    [findVC.tabBarItem setImage:[UIImage imageNamed:@"icon-4"]];

    //我
    MeView *meVC = [[MeView alloc] init];
    [meVC.view
        setBackgroundColor:[UIColor colorWithRed:arc4random() % 255 / 255.0
                                           green:arc4random() % 255 / 255.0
                                            blue:arc4random() % 255 / 255.0
                                           alpha:1]];
    SuperNavigationController *meNVC =
        [[SuperNavigationController alloc] initWithRootViewController:meVC];
    meVC.tabBarItem.title = @"我";
    [meVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon-5"]];
    [meVC.tabBarItem setImage:[UIImage imageNamed:@"icon-5"]];

    _tabBarC = [[UITabBarController alloc] init];
    [_tabBarC
        setViewControllers:@[ newsNVC, messagesNVC, AppNVC, findNVC, meNVC ]
                  animated:YES];
  }
  return _tabBarC;
}
- (SuperNavigationController *)landingNVC {
  if (!_landingNVC) {
    LandingView *landingVC = [[LandingView alloc] init];
    landingVC.tabBarItem.title = @"登陆";
    _landingNVC = [[SuperNavigationController alloc]
        initWithRootViewController:landingVC];
  }
  return _landingNVC;
}

-(SuperNavigationController *)mainNVC
{
    if (!_mainNVC) {
        MainViewC *mainVC = [MainViewC new];
        mainVC.title = @"登陆";
        _mainNVC = [[SuperNavigationController alloc]initWithRootViewController:mainVC];
        
    }
    return _mainNVC;
}

- (SuperNavigationController *)findNVC {
    if (!_findNVC) {
        FindView *findVC = [[FindView alloc] init];
        findVC.tabBarItem.title = @"发现";
        _findNVC = [[SuperNavigationController alloc]
                       initWithRootViewController:findVC];
    }
    return _findNVC;
}

- (UserModel *)userModel {
  if (!_userModel) {
    _userModel = [[UserModel alloc] init];
  }
  return _userModel;
}




@end
