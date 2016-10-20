//
//  AppView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "AppView.h"
#import "AppViewModel.h"

@interface AppView ()
@property(nonatomic, strong) AppViewModel *viewModel;


@end

@implementation AppView

- (void)viewDidLoad {
    self.viewModel = [[AppViewModel alloc]initWithViewController:self];
    [super viewDidLoad];
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//         self.viewModel = [[AppViewModel alloc]initWithViewController:self];
//        
//    }
//    return self;
//}

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

#pragma mark - 控制器生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.webView);
    [self.webView loadRequestWithUrlString:meURL];
    
    NSLog(@"%@",self.view.subviews);
    
    self.navigationController.navigationBarHidden = NO;
}


- (void)dealloc {
    [self.webView.configuration.userContentController
     removeScriptMessageHandlerForName:MessageHandlerApp];
}

#pragma mark - 懒加载

- (void)webViewLoadRequestWithUrlString:(NSString *)urlStr
                       endConfiguration:(WKWebViewConfiguration *)config
                            endDelegate:(id)delegate
                 endtMessageHandlerName:(NSString *)name {
    [super webViewLoadRequestWithUrlString:appURL
                          endConfiguration:config
                               endDelegate:self.viewModel
                    endtMessageHandlerName:MessageHandlerApp];
}
@end
