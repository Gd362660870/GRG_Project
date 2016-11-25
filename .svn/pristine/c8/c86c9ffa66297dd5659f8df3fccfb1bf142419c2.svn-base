//
//  SuperVC.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "SuperVC.h"
#import "SuperViewModel.h"
#import "UIView+Progress.h"


@interface SuperVC ()

@end

@implementation SuperVC


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //添加视图
    [self addViews];
    
    //适配
    [self defineLayout];
    
    //关联
    [self bindWithViewModel];
    
}

#pragma mark - 添加视图
- (void)addViews {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    [self.view addSubview:self.webView];
    NSLog(@"webViewwebView---->%@",self.webView);
    [self.view addSubview: self.progressView];
    
    
//    [self test];
}

-(void)test
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    [view setBackgroundColor:[UIColor redColor]];
    
    [view startProgresView];
    [self.view addSubview:view];
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.mas_equalTo(self.view)
        .width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(20);
    }];
    
}

#pragma mark - 适配
- (void)defineLayout {
    
//     [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.right.bottom.left.mas_equalTo(self.view)
//         .width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//         make.top.mas_equalTo(self.progressView.mas_bottom);
//     }];
    

    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(100);
    }];
    
}

#pragma mark - 关联
-(void)bindWithViewModel
{
   
}

- (void)dealloc{
    
}


#pragma mark - 懒加载



- (SuperWKWebView *)webView {
    if (!_webView) {
        // 创建配置
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // // 创建UserContentController（提供JavaScript向webView发送消息的方法）
        config.userContentController = [[WKUserContentController alloc] init];
        
        
 
        //保存cookieScript
        WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: @"document.cookie ='TeskCookieKey1=TeskCookieValue1';document.cookie = 'TeskCookieKey2=TeskCookieValue2';" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        
        [config.userContentController addUserScript:cookieScript];
        
        
//        _webView =
//        [[SuperWKWebView alloc] initWithFrame:CGRectZero configuration:config];
        
//        _webView =[SuperWKWebView sharedWebViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
        
        //设置滚动视图内容距离
        [_webView.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        _webView.allowsBackForwardNavigationGestures = YES;
        //滚动指标插图从滚动视图边缘的距离。
        [_webView.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        

//        [self webViewLoadRequestWithUrlString:nil endConfiguration:config endDelegate:nil endtMessageHandlerName:nil];
  
    }
    return _webView;
}

-(void)webViewLoadRequestWithUrlString:(NSString *)urlStr endConfiguration:(WKWebViewConfiguration *)config endDelegate:(id)delegate endtMessageHandlerName:(NSString *)name
{
    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    [config.userContentController addScriptMessageHandler:delegate name:name];
    
    //设置代理
    [_webView setNavigationDelegate:delegate];
    [_webView setUIDelegate:delegate];
    
    //加载路径
    [_webView loadRequestWithUrlString:urlStr];
}


- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]
                         initWithProgressViewStyle:UIProgressViewStyleDefault];        
    }
    return _progressView;
}


@end
