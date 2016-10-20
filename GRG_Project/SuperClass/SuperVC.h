//
//  SuperVC.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperNavigationController.h"
#import "SuperWKWebView.h"
#import "UIProgressView+CJJ.h"
@class SuperViewModel;
@interface SuperVC : UIViewController

@property(nonatomic, weak) SuperWKWebView *webView;
@property(nonatomic, strong) UIProgressView *progressView;

/**
 *  添加视图
 */
-(void)addViews;

/**
 *  适配
 */
-(void)defineLayout;


/**
 *  关联
 */
-(void)bindWithViewModel;


/**
 *  这里设置加载路径、代理、以及config注入  (需要重写父类)
 *
 *  @param urlStr   路径
 *  @param config   config
 *  @param delegate 代理
 *  @param name
 */
-(void)webViewLoadRequestWithUrlString:(NSString *)urlStr endConfiguration:(WKWebViewConfiguration *)config endDelegate:(id)delegate endtMessageHandlerName:(NSString *)name;




@end
