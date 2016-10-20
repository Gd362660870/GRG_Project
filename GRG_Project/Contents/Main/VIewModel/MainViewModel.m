//
//  MainViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/13.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "MainViewModel.h"
#import "ScannerViewController.h"

@interface MainViewModel ()
@property(nonatomic,strong) AFNetworkReachabilityManager *mannger;
@end

@implementation MainViewModel

#pragma mark - 入口
- (instancetype)initWithViewController:(id)controller {
  self = [super init];
  if (self) {
    self.view = controller;
    [self processingSignal];
  }
  return self;
}
#pragma mark - 处理Web_RUl 事件
-(void)WebViewURLAction:(NSURL *)url
{
    //获取URL相对路径
    NSString *relativePath = url.relativePath;
    NSLog(@"relativePath----->%@", relativePath);
    if ([relativePath isEqualToString:@"/MySetting/Index"] ||
        [relativePath isEqualToString:@"/Contacts/Index"] ||
        [relativePath isEqualToString:@"/Application/Index"] ||
        [relativePath isEqualToString:@"/Finding/Index"] ||
        [relativePath isEqualToString:@"/Home/Index"]) {
        [self.subjectUI sendNext:@(MainViewTabBarTypeShow)];
        
        if ([relativePath isEqualToString:@"/MySetting/Index"]) {
            [self.subjectUI sendNext:@(MainViewTabBarBtnSelectedTypeMe)];
        }else if ([relativePath isEqualToString:@"/Contacts/Index"])
        {
            [self.subjectUI sendNext:@(MainViewTabBarBtnSelectedTypeNews)];
        }else if ([relativePath isEqualToString:@"/Application/Index"])
        {
            [self.subjectUI sendNext:@(MainViewTabBarBtnSelectedTypeAPP)];
        }else if ([relativePath isEqualToString:@"/Finding/Index"])
        {
            [self.subjectUI sendNext:@(MainViewTabBarBtnSelectedTypeFind)];
        }else if ([relativePath isEqualToString:@"/Home/Index"])
        {
            [self.subjectUI sendNext:@(MainViewTabBarBtnSelectedTypeMessages)];
        }
        
    }else
    {
        [self.subjectUI sendNext:@(MainViewTabBarTypeHide)];
    }
}

#pragma mark - 信号处理
- (void)processingSignal {
    
    [RACObserve(self, loading)subscribeNext:^(id x) {
        int loading = [x intValue];
        if (loading == 0) {
            //加载完毕
            //删除标签栏 导航条
            NSString *removeTab = @"$('div.tab-nav.tabs').remove();$('header.header').remove();";
            
            [self.view.webView evaluateJavaScript:removeTab completionHandler:^(id _Nullable
                                                                      item, NSError * _Nullable error) {
                
            }];
            NSLog(@"%d",loading);
        }else
        {
            NSLog(@"%d",loading);
            //正在加载
        }
    }];
    
    //网络状态
    [self.mannger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *result = @"";
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                result = @"mannger--->未知网络";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                result = @"mannger--->无网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                result = @"mannger--->WAN";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                result = @"mannger--->WIFI";
                break;
                
            default:
                break;
        }
        NSLog(@"%@",result);
    }];
    

    
}

#pragma mark - 二维码
- (void)openScanner {
    
    ScannerViewController *scannerVC = [[ScannerViewController alloc] init];
    
    [self.view.navigationController pushViewController:scannerVC animated:YES];
    
    
}

#pragma mark - WKNavigationDelegate

//-------------------------按顺序执行--------------------------

//在发送请求之前，决定是否继续处理。根据webView、navigationAction相关信息决定这次跳转
//是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept。
- (void)webView:(WKWebView *)webView
    decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
                    decisionHandler:
                        (void (^)(WKNavigationActionPolicy))decisionHandler {
  NSLog(@"在发送请求之前，决定是否继续处理");

  NSURL *URL = navigationAction.request.URL;
  //    [[CJJ_Tools sharedTools]properties_aps:self];

  NSString *relativePath = [URL relativePath];

    if ([relativePath isEqualToString:@"/Finding/Scanning"]) {
        
        //跳转到页面
        [self openScanner];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

//开始加载页面调用
- (void)webView:(WKWebView *)webView
    didStartProvisionalNavigation:(WKNavigation *)navigation {
  //显示进度条
  self.ProgressHide = NO;
  NSLog(@"开始加载页面调用");
    //显示加载视图
    [self.subjectUI sendNext:@(MainViewLoadViewTypeShow)];
}

//在收到响应后，决定是否继续处理。根据response相关信息，可以决定这次跳转是否可以继续进行。
- (void)webView:(WKWebView *)webView
    decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
                      decisionHandler:(void (^)(WKNavigationResponsePolicy))
                                          decisionHandler {
  decisionHandler(WKNavigationResponsePolicyAllow);
  NSLog(@"在收到响应后，决定是否继续处理");
}

//内容开始返回时调用
- (void)webView:(WKWebView *)webView
    didCommitNavigation:(WKNavigation *)navigation {
  NSLog(@"内容开始返回时调用");
}

//页面加载完成后调用
- (void)webView:(WKWebView *)webView
    didFinishNavigation:(WKNavigation *)navigation {
    [self WebViewURLAction:webView.URL];
  NSLog(@"页面加载完成后调用");
  //隐藏进度条
  self.ProgressHide = YES;
  [self.appDelegate.userModel AddCookie];


    
    //隐藏加载视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.subjectUI sendNext:@(MainViewLoadViewTypeHide)];
    });
    
    
    
}
//页面加载失败时调用
- (void)webView:(WKWebView *)webView
    didFailProvisionalNavigation:(WKNavigation *)navigation
                       withError:(NSError *)error {
  //隐藏进度条
  self.ProgressHide = YES;
  NSLog(@"页面加载失败时调用");
}

//// 接收到服务器跳转请求之后调用(重定向)
- (void)webView:(WKWebView *)webView
    didReceiveServerRedirectForProvisionalNavigation:
        (WKNavigation *)navigation {
  NSLog(@"接收到服务器跳转请求之后调用");
}

//-------------------------其它三个方法--------------------------

// navigation发生错误时调用
- (void)webView:(WKWebView *)webView
    didFailNavigation:(null_unspecified WKNavigation *)navigation
            withError:(NSError *)error {
  NSLog(@"navigation发生错误时调用");
}

// web视图需要响应身份验证时调用。
- (void)
                          webView:(WKWebView *)webView
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
                completionHandler:
                    (void (^)(NSURLSessionAuthChallengeDisposition disposition,
                              NSURLCredential *__nullable credential))
                        completionHandler {
  NSLog(@"web视图需要响应身份验证时调用");
}

// web视图需要响应身份验证时调用。
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
    NS_AVAILABLE(10_11, 9_0) {
  NSLog(@"web视图需要响应身份验证时调用。");
}

#pragma mark - WKUIDelegate

// 3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView
    runJavaScriptAlertPanelWithMessage:(NSString *)message
                      initiatedByFrame:(WKFrameInfo *)frame
                     completionHandler:(void (^)(void))completionHandler {
  NSLog(@"显示一个JS的Alert（与JS交互）");
  NSLog(@"%@", message);
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@"警告"
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction
                       actionWithTitle:@"确定"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *_Nonnull action) {
                                 completionHandler();
                               }]];

  [self.appDelegate.window.rootViewController presentViewController:alert
                                                           animated:YES
                                                         completion:NULL];
}
// 4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView
    runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt
                              defaultText:(nullable NSString *)defaultText
                         initiatedByFrame:(WKFrameInfo *)frame
                        completionHandler:
                            (void (^)(NSString *__nullable result))
                                completionHandler {
  NSLog(@"弹出一个输入框（与JS交互的）");
  NSLog(@"%@", prompt);
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@"textinput"
                                          message:@"JS调用输入框"
                                   preferredStyle:UIAlertControllerStyleAlert];
  [alert
      addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
        textField.textColor = [UIColor redColor];
      }];

  [alert addAction:[UIAlertAction
                       actionWithTitle:@"确定"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *_Nonnull action) {
                                 completionHandler(
                                     [[alert.textFields lastObject] text]);
                               }]];

  [self.appDelegate.window.rootViewController presentViewController:alert
                                                           animated:YES
                                                         completion:NULL];
}
// 5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView
    runJavaScriptConfirmPanelWithMessage:(NSString *)message
                        initiatedByFrame:(WKFrameInfo *)frame
                       completionHandler:
                           (void (^)(BOOL result))completionHandler {
  NSLog(@"显示一个确认框（JS的）");
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@"confirm"
                                          message:@"JS调用confirm"
                                   preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction
                       actionWithTitle:@"确定"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *_Nonnull action) {
                                 completionHandler(YES);
                               }]];
  [alert addAction:[UIAlertAction
                       actionWithTitle:@"取消"
                                 style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *_Nonnull action) {
                                 completionHandler(NO);
                               }]];

  [self.appDelegate.window.rootViewController presentViewController:alert
                                                           animated:YES
                                                         completion:NULL];

  NSLog(@"%@", message);
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
  if (message.body[@"body"]) {
    NSLog(@"%@", message.body[@"body"]);
  } else if (message.body[@"body02"]) {
    NSLog(@"%@", message.body);
  }

  NSLog(@"name->%@  body->%@", message.name, message.body);

  if ([message.name isEqualToString:@"IOS_API"]) {
    // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
    // NSDictionary, and NSNull类型
    NSLog(@"body->%@   body_class->%@", message.body, [message.body class]);
  }
}

#pragma mark - dealloc
- (void)dealloc {
  NSLog(@"%s", __func__);
}

#pragma mark - 懒加载

-(AFNetworkReachabilityManager *)mannger
{
    
    if (!_mannger) {
        _mannger =   [AFNetworkReachabilityManager sharedManager];
        
        [_mannger startMonitoring];
    }
    return _mannger;
}

- (MainModel *)model {
  if (!_model) {
    _model = [[MainModel alloc] init];
  }
  return _model;
}

- (AppDelegate *)appDelegate {
  if (!_appDelegate) {
    _appDelegate = [UIApplication sharedApplication].delegate;
  }
  return _appDelegate;
}
- (RACSubject *)subjectUI {
  if (!_subjectUI) {
    _subjectUI = [RACSubject subject];
  }
  return _subjectUI;
}
@end
