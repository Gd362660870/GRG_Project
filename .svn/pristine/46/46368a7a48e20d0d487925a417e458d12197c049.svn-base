//
//  MainViewModel.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/13.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainModel.h"
#import "AppDelegate.h"
#import "MainViewC.h"
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSInteger,MainViewUIType){
    MainViewTabBarTypeHide = 0,//隐藏tabbar
    MainViewTabBarTypeShow,//显示tabbar
    MainViewTabBarBtnSelectedTypeMessages,//高亮显示Messages按钮
    MainViewTabBarBtnSelectedTypeFind,//高亮显示Find按钮
    MainViewTabBarBtnSelectedTypeNews,//高亮显示News按钮
    MainViewTabBarBtnSelectedTypeMe,//高亮显示Me按钮
    MainViewTabBarBtnSelectedTypeAPP,//高亮显示APP按钮
    MainViewLoadViewTypeHide,//隐藏加载视图
    MainViewLoadViewTypeShow,//显示加载视图
};


@interface MainViewModel : NSObject<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic,weak)MainViewC *view;
@property (nonatomic,strong)MainModel *model;

@property (nonatomic,strong) AppDelegate *appDelegate;
@property (nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSNumber *loading;
@property(nonatomic,assign)BOOL ProgressHide;
@property(nonatomic,strong)NSNumber *Progress;

/**
 *  处理UI事件信号
 */
@property (nonatomic,strong)RACSubject *subjectUI;


- (instancetype)initWithViewController:(id)controller;


-(void)processingSignal;
@end
