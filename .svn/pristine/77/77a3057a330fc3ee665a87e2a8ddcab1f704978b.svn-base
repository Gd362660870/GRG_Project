//
//  SuperViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "SuperViewModel.h"
#import "SuperVC.h"
#import "SuperModel.h"
#import <objc/runtime.h>

@interface SuperViewModel()



@end

@implementation SuperViewModel



- (instancetype)initWithViewController:(id)controller
{
    self = [super init];
    if (self) {
        
        
        self.ProgressHide = NO;
        //处理信号
        [self processingSignal];
        
    }
    return self;
}


#pragma mark - 处理信号
-(void)processingSignal
{

}




#pragma mark - WKNavigationDelegate

//-------------------------按顺序执行--------------------------

//在发送请求之前，决定是否继续处理。根据webView、navigationAction相关信息决定这次跳转
//是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    
    NSLog(@"在发送请求之前，决定是否继续处理");
    
    NSURL *URL = navigationAction.request.URL;
    //    [[CJJ_Tools sharedTools]properties_aps:self];
    NSString *scheme = [URL scheme];
    NSLog(@"scheme----->%@",scheme);
    if ([scheme isEqualToString:@"haleyaction"]) {
        //        [self handleCustomAction:URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
}




//开始加载页面调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //显示进度条
    self.ProgressHide = NO;
    NSLog(@"开始加载页面调用");
}

//在收到响应后，决定是否继续处理。根据response相关信息，可以决定这次跳转是否可以继续进行。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:
(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"在收到响应后，决定是否继续处理");
}

//内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"内容开始返回时调用");
}

//页面加载完成后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成后调用");
    //隐藏进度条
    self.ProgressHide = YES;
    [self.appDelegate.userModel AddCookie];
    
    //删除标签栏 导航条
    NSString *removeTab = @"$('div.tab-nav.tabs').remove();";
    NSString *removeNV = @"$('header.header').remove();";
    
    [webView evaluateJavaScript:removeTab completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        NSLog(@"%@",item);
    }];
    
    [webView evaluateJavaScript:removeNV completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        NSLog(@"%@",item);
    }];
    
    
 
    
    
}
//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    //隐藏进度条
    self.ProgressHide = YES;
    NSLog(@"页面加载失败时调用");
}

//// 接收到服务器跳转请求之后调用(重定向)
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"接收到服务器跳转请求之后调用");
}

//-------------------------其它三个方法--------------------------

//navigation发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation
      withError:(NSError *)error{
    NSLog(@"navigation发生错误时调用");
}

//web视图需要响应身份验证时调用。
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
                            NSURLCredential *__nullable credential))completionHandler{
    NSLog(@"web视图需要响应身份验证时调用");
}

//web视图需要响应身份验证时调用。
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
    NSLog(@"web视图需要响应身份验证时调用。");
}

#pragma mark - WKUIDelegate


//3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"显示一个JS的Alert（与JS交互）");
    NSLog(@"%@", message);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:message  preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self.appDelegate.window.rootViewController presentViewController:alert animated:YES completion:NULL];
}
//4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    NSLog(@"弹出一个输入框（与JS交互的）");
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    
    
    [self.appDelegate.window.rootViewController presentViewController:alert animated:YES completion:NULL];
}
//5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    NSLog(@"显示一个确认框（JS的）");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:@"JS调用confirm" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    
    
    [self.appDelegate.window.rootViewController presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}




#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if (message.body[@"body"]) {
        NSLog(@"%@",message.body[@"body"] );
    }else if (message.body[@"body02"])
    {
        NSLog(@"%@",message.body);
    }
    
    NSLog(@"name->%@  body->%@",message.name,message.body);
    
    if ([message.name isEqualToString:@"IOS_API"]) {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        NSLog(@"body->%@   body_class->%@", message.body,[message.body class]);
    }
}



#pragma mark-初始化


-(AppDelegate *)appDelegate
{
    if (!_appDelegate) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}
@end

