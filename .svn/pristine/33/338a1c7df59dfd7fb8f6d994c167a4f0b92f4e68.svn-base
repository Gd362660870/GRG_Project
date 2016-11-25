//
//  FindViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "FindModel.h"
#import "FindView.h"
#import "FindViewModel.h"
#import "ScannerViewController.h"
#import "TestViewController.h"
//#import "QRCScannerViewController.h"

@interface FindViewModel ()
@property(nonatomic, weak) FindView *viewC;

@property(nonatomic, strong) FindModel *model;
@end

@implementation FindViewModel

- (instancetype)initWithViewController:(id)controller {
  self = [super initWithViewController:controller];
  self.viewC = controller;
  return self;
}

#pragma mark - 处理信号
- (void)processingSignal {
  [super processingSignal];
}

#pragma mark - 二维码
- (void)openScanner {
    
  ScannerViewController *scannerVC = [[ScannerViewController alloc] init];
    
  [self.viewC.navigationController pushViewController:scannerVC animated:YES];
    

}

-(void)test
{
    TestViewController *test = [[TestViewController alloc]init];
    [self.viewC.navigationController pushViewController:test animated:YES];
}
- (void)didFinshedScanning:(NSString *)result
{
    NSLog(@"%@",result);
}

#pragma mark - WKNavigationDelegate

//-------------------------按顺序执行--------------------------

//在发送请求之前，决定是否继续处理。根据webView、navigationAction相关信息决定这次跳转
//是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept。
- (void)webView:(WKWebView *)webView
    decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
                    decisionHandler:
                        (void (^)(WKNavigationActionPolicy))decisionHandler {
//  [super webView:webView
//      decidePolicyForNavigationAction:navigationAction
//                      decisionHandler:decisionHandler];
    

    
    NSURL *URL = navigationAction.request.URL;
    //    [[CJJ_Tools sharedTools]properties_aps:self];
    
    NSString *relativePath = [URL relativePath];
    
    NSLog(@"relativePath----->%@",relativePath);
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
  [super webView:webView didStartProvisionalNavigation:navigation];
}

//在收到响应后，决定是否继续处理。根据response相关信息，可以决定这次跳转是否可以继续进行。
- (void)webView:(WKWebView *)webView
    decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
                      decisionHandler:(void (^)(WKNavigationResponsePolicy))
                                          decisionHandler {
  [super webView:webView
      decidePolicyForNavigationResponse:navigationResponse
                        decisionHandler:decisionHandler];
}

//内容开始返回时调用
- (void)webView:(WKWebView *)webView
    didCommitNavigation:(WKNavigation *)navigation {
  [super webView:webView didCommitNavigation:navigation];
}

//页面加载完成后调用
- (void)webView:(WKWebView *)webView
    didFinishNavigation:(WKNavigation *)navigation {
  [super webView:webView didFinishNavigation:navigation];
}
//页面加载失败时调用
- (void)webView:(WKWebView *)webView
    didFailProvisionalNavigation:(WKNavigation *)navigation
                       withError:(NSError *)error {
  [super webView:webView
      didFailProvisionalNavigation:navigation
                         withError:error];
}

// 接收到服务器跳转请求之后调用(重定向)
- (void)webView:(WKWebView *)webView
    didReceiveServerRedirectForProvisionalNavigation:
        (WKNavigation *)navigation {
  [super webView:webView
      didReceiveServerRedirectForProvisionalNavigation:navigation];
}

//-------------------------其它三个方法--------------------------

// navigation发生错误时调用
- (void)webView:(WKWebView *)webView
    didFailNavigation:(null_unspecified WKNavigation *)navigation
            withError:(NSError *)error {
  [super webView:webView didFailNavigation:navigation withError:error];
}

// web视图需要响应身份验证时调用。
- (void)
                          webView:(WKWebView *)webView
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
                completionHandler:
                    (void (^)(NSURLSessionAuthChallengeDisposition disposition,
                              NSURLCredential *__nullable credential))
                        completionHandler {
  [super webView:webView
      didReceiveAuthenticationChallenge:challenge
                      completionHandler:completionHandler];
}

// web视图需要响应身份验证时调用。
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
    NS_AVAILABLE(10_11, 9_0) {
  [super webViewWebContentProcessDidTerminate:webView];
}

#pragma mark - WKUIDelegate

// 3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView
    runJavaScriptAlertPanelWithMessage:(NSString *)message
                      initiatedByFrame:(WKFrameInfo *)frame
                     completionHandler:(void (^)(void))completionHandler {
  [super webView:webView
      runJavaScriptAlertPanelWithMessage:message
                        initiatedByFrame:frame
                       completionHandler:completionHandler];
}
// 4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView
    runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt
                              defaultText:(nullable NSString *)defaultText
                         initiatedByFrame:(WKFrameInfo *)frame
                        completionHandler:
                            (void (^)(NSString *__nullable result))
                                completionHandler {
  [super webView:webView
      runJavaScriptTextInputPanelWithPrompt:prompt
                                defaultText:defaultText
                           initiatedByFrame:frame
                          completionHandler:completionHandler];
}
// 5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView
    runJavaScriptConfirmPanelWithMessage:(NSString *)message
                        initiatedByFrame:(WKFrameInfo *)frame
                       completionHandler:
                           (void (^)(BOOL result))completionHandler {
  [super webView:webView
      runJavaScriptConfirmPanelWithMessage:message
                          initiatedByFrame:frame
                         completionHandler:completionHandler];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
  [super userContentController:userContentController
       didReceiveScriptMessage:message];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *, id> *)change
                       context:(void *)context {
  [super observeValueForKeyPath:keyPath
                       ofObject:object
                         change:change
                        context:context];
}


#pragma mark -懒加载
- (FindModel *)model {
  if (!_model) {
    _model = [[FindModel alloc] init];
  }
  return _model;
}

@end
