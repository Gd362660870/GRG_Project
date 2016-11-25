//
//  SuperViewModel.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import "SuperWKWebView.h"

@interface SuperViewModel : NSObject<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) AppDelegate *appDelegate;
@property (nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSNumber *loading;
@property(nonatomic,assign)BOOL ProgressHide;
@property(nonatomic,strong)NSNumber *Progress;




- (instancetype)initWithViewController:(id)controller;


-(void)processingSignal;


@end
