//
//  LandingView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/29.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "LandingView.h"
#import "LandingViewModel.h"

@interface LandingView ()
@property(nonatomic, strong) LandingViewModel *viewModel;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation LandingView

- (void)viewDidLoad {
  [super viewDidLoad];

    
    self.viewModel = [[LandingViewModel alloc] initWithViewController:self];

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
  [self.view addSubview:self.webView];
}

#pragma mark - 适配
- (void)defineLayout {
  [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.right.bottom.left.mas_equalTo(self.view)
        .width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
  }];
}

#pragma mark - 关联
- (void)bindWithViewModel {
    
    //绑定加载信号
//          RAC(self,viewModel.loading) = [[_webView rac_valuesAndChangesForKeyPath:@"loading"
//          options:NSKeyValueObservingOptionNew observer:nil]map:^id(id value) {
//              //item 1 = 正在加载   item 0 = 加载完成
//              RACTupleUnpack(NSNumber *item) = value;
//              return item;
//          }];
    
    //绑定标题
  RAC(self,title) = [[_webView rac_valuesAndChangesForKeyPath:@"title"
                                    options:NSKeyValueObservingOptionNew
                                   observer:nil] map:^id(id value) {
      RACTupleUnpack(NSString *item) = value;
      return item;
  }];

    //绑定进度条
  RAC(self,viewModel.loading) = [[_webView rac_valuesAndChangesForKeyPath:@"estimatedProgress"
                                    options:NSKeyValueObservingOptionNew
                                   observer:nil]map:^id(id value) {
      RACTupleUnpack(NSNumber *item) = value;
      //item = 0.0 ~ 1.0 表示进度时间
      return item;
  }];
    
    [RACObserve(self, title)subscribeNext:^(id x) {
        NSLog(@"x---->%@",x);
    }];
    
    [RACObserve(self, viewModel.loading)subscribeNext:^(id x) {
        NSLog(@"y---->%@",x);
    }];
    
    
    

}

#pragma mark -dealloc
- (void)dealloc {
  [self.webView.configuration.userContentController
      removeScriptMessageHandlerForName:@"IOS_API"];
}

#pragma mark - 懒加载
//- (LandingViewModel *)viewModel {
//  if (!_viewModel) {
//    _viewModel = [[LandingViewModel alloc] initWithViewController:self];
//  }
//  return _viewModel;
//}

- (SuperWKWebView *)webView {
  if (!_webView) {
    // 创建配置
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];

    // // 创建UserContentController（提供JavaScript向webView发送消息的方法）
    config.userContentController = [[WKUserContentController alloc] init];

    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    [config.userContentController addScriptMessageHandler:self.viewModel
                                                     name:@"IOS_API"];
      
  
      
      
      _webView.allowsBackForwardNavigationGestures =YES;
      

    _webView =
        [[SuperWKWebView alloc] initWithFrame:CGRectZero configuration:config];

              NSMutableURLRequest *mURLRequest = [NSMutableURLRequest
              requestWithURL:[NSURL URLWithString:landingURL]];
    //
        [_webView loadRequest:mURLRequest];

//    NSError *error = nil;
//    NSString *strUrl =
//        [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
//                                               pathForResource:@"test.html"
//                                                        ofType:nil]
//                                  encoding:NSUTF8StringEncoding
//                                     error:&error];
//    ;
//    if (error) {
//      NSLog(@"%@", error);
//      NSLog(@"%@", strUrl);
//    }
//    NSLog(@"%@", strUrl);
//    [_webView loadHTMLString:strUrl baseURL:nil];

    //设置滚动视图内容距离
    [_webView.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];

    //滚动指标插图从滚动视图边缘的距离。
    [_webView.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_webView setNavigationDelegate:self.viewModel];
    [_webView setUIDelegate:self.viewModel];

//      [_webView evaluateJavaScript:@"alert(123)" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
//          NSLog(@"%@",item);
//      }];
  }
  return _webView;
}

//- (SuperWebView *)webView {
//  if (!_webView) {
//    _webView = [[SuperWebView alloc] initWithFrame:CGRectZero];
//    [_webView setDelegate:self.viewModel];
//
//      NSMutableURLRequest *request = [NSMutableURLRequest
//      requestWithURL:[NSURL URLWithString:landingURL]];
////      NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
/// cookies];
////      NSDictionary *headers = [NSHTTPCookie
/// requestHeaderFieldsWithCookies:cookies];
////      [request setHTTPMethod:@"GET"];
////      [request setHTTPShouldHandleCookies:YES];
////      [request setAllHTTPHeaderFields:headers];
//
//    [_webView loadRequest:request];
//
//    //设置滚动视图内容距离
//    [_webView.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//
//    //滚动指标插图从滚动视图边缘的距离。
//    [_webView.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0,
//    0)];
//
//
//
//
//
//
//
//  }
//  return _webView;
//}

-(UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        
    }
    return _progressView;
}

@end
