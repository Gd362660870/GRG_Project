//
//  LandingView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/29.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "LandingView.h"
#import "LandingViewModel.h"
#import "UIProgressView+CJJ.h"



@interface LandingView ()
@property(nonatomic, strong) LandingViewModel *viewModel;


@end

@implementation LandingView

- (void)viewDidLoad {
   self.viewModel = [[LandingViewModel alloc]initWithViewController:self];
  [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
}

#pragma mark - 添加视图
- (void)addViews {
  [super addViews];
    [self.view addSubview:self.webView];
}

#pragma mark - 适配
- (void)defineLayout {
  [super defineLayout];
}

#pragma mark - 关联
- (void)bindWithViewModel {
  [super bindWithViewModel];

  //    @weakify(self)
    
    
    RAC(self, viewModel.loading) =
    [[self.webView rac_valuesAndChangesForKeyPath:@"loading"
                                          options:NSKeyValueObservingOptionNew
                                         observer:nil] map:^id(id value) {
        // item 1 = 正在加载   item 0 = 加载完成
        RACTupleUnpack(NSNumber * item) = value;
        return item;
    }];
    
    //绑定标题
    RAC(self, title) =
    [[self.webView rac_valuesAndChangesForKeyPath:@"title"
                                          options:NSKeyValueObservingOptionNew
                                         observer:nil] map:^id(id value) {
        //          @strongify(self)
        RACTupleUnpack(NSString * item) = value;
        return item;
    }];
    
    //绑定进度条
    //    estimatedProgress
    RAC(self, progressView.progress) =
    [[self.webView rac_valuesAndChangesForKeyPath:@"estimatedProgress"
                                          options:NSKeyValueObservingOptionNew
                                         observer:nil] map:^id(id value) {
        //          @strongify(self)
        RACTupleUnpack(NSNumber * item) = value;
        // item = 0.0 ~ 1.0 表示进度时间
        return item;
    }];
    
    //绑定进度条Hide
    RAC(self, progressView.hidden) = RACObserve(self, viewModel.ProgressHide);

 
}


#pragma mark -声明周期

-(void)viewWillAppear:(BOOL)animated
{
    [self.webView loadRequestWithUrlString:landingURL];
    NSLog(@"%@",self.webView);
}
- (void)dealloc {
  [self.webView.configuration.userContentController
      removeScriptMessageHandlerForName:MessageHandlerLanding];
}

#pragma mark - 懒加载

- (void)webViewLoadRequestWithUrlString:(NSString *)urlStr
                       endConfiguration:(WKWebViewConfiguration *)config
                            endDelegate:(id)delegate
                 endtMessageHandlerName:(NSString *)name {
  [super webViewLoadRequestWithUrlString:landingURL
                        endConfiguration:config
                             endDelegate:self.viewModel
                  endtMessageHandlerName:MessageHandlerLanding];
}

@end
