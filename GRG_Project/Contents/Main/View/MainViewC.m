//
//  MainViewC.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/13.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "MainViewC.h"
#import "MainTabBar.h"
#import "MainViewModel.h"
#import "LoadView.h"
#import "UIButton+Type.h"

@interface MainViewC ()
@property (nonatomic,strong)MainTabBar *tabBarView;//标签栏
@property (nonatomic,strong)LoadView *loadV; //加载视图
@property (nonatomic,strong)MainViewModel *viewModel;



@end

@implementation MainViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //添加视图
    [self addViews];
    
    //适配
    [self defineLayout];
    
    //关联
    [self bindWithViewModel];
    
}

#pragma mark- 添加视图
-(void)addViews
{
    //设置导航
    [self setNavigationBar];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.tabBarView];
    [self.webView addSubview:self.loadV];
}

#pragma mark- 设置导航
-(void)setNavigationBar
{
    //设置导航样式
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;

    UIButton * gobackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [gobackBtn setFrame:CGRectMake(0, 0, 25, 25)];
    [gobackBtn setBackgroundImage:[UIImage imageNamed:@"icon-13"] forState:UIControlStateNormal];
    [gobackBtn setBackgroundImage:[UIImage imageNamed:@"icon-11"] forState:UIControlStateSelected];
    
    
    UIButton * gofarwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [gofarwardBtn setFrame:CGRectMake(0, 0, 25, 25)];
    [gofarwardBtn setBackgroundImage:[UIImage imageNamed:@"icon-12"] forState:UIControlStateNormal];
    [gofarwardBtn setBackgroundImage:[UIImage imageNamed:@"icon-10"] forState:UIControlStateSelected];
    
    
    
    
    
    UIButton * homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setFrame:CGRectMake(0, 0, 25, 25)];
    [homeBtn setBackgroundImage:[UIImage imageNamed:@"icon-7"] forState:UIControlStateNormal];
    
    
    
    UIBarButtonItem *leftBarBtn_1 = [[UIBarButtonItem alloc]initWithCustomView:gobackBtn];
    UIBarButtonItem *blankBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"   " style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *leftBarBtn_2 = [[UIBarButtonItem alloc]initWithCustomView:gofarwardBtn];
    UIBarButtonItem *rightBarBtn_Home = [[UIBarButtonItem alloc]initWithCustomView:homeBtn];
    
    
    [self.navigationItem setLeftBarButtonItems:@[leftBarBtn_1,blankBarBtn,leftBarBtn_2]];
    [self.navigationItem setRightBarButtonItem:rightBarBtn_Home];
    
#pragma mark- 绑定导航事件
    //后退
    RAC(gobackBtn,selected) = RACObserve(self, webView.canGoBack);
    RAC(gobackBtn,userInteractionEnabled) = RACObserve(self, webView.canGoBack);
    [gobackBtn addTarget:self action:@selector(gobackAction) forControlEvents:UIControlEventTouchUpInside];
    
    //前进
    RAC(gofarwardBtn,selected) = RACObserve(self, webView.canGoForward);
    RAC(gofarwardBtn,userInteractionEnabled) = RACObserve(self, webView.canGoForward);
    [gofarwardBtn addTarget:self action:@selector(gofarwardAction) forControlEvents:UIControlEventTouchUpInside];
    
    //首页
    [homeBtn addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

//后退
- (void)gobackAction {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}
//前进
- (void)gofarwardAction {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    
    }
}

//首页
-(void)homeAction:(UIButton *)btn
{
    
    
    
    [btn NACBarButton_Home_Animation];
    
    [self.webView loadRequestWithUrlString:messagesURL];
}

#pragma mark- 适配
-(void)defineLayout
{
    @weakify(self)
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view).insets(UIEdgeInsetsMake(NavigationBar_Height_2, 0, 0, 0));
       @strongify(self)
        make.bottom.mas_equalTo(self.tabBarView.mas_top);
    }];
    
    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.height.mas_equalTo(TabBar_Height_1);
        make.left.right.bottom.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.loadV mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
//        make.left.top.bottom.right.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        make.size.sizeOffset(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH));
//        make.center.mas_equalTo(self.view);
        
        make.left.right.top.bottom.mas_equalTo(self.webView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
}


#pragma mark- 关联
-(void)bindWithViewModel
{
    @weakify(self)
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
    
    [RACObserve(self, webView.estimatedProgress)subscribeNext:^(id x) {
        @strongify(self)
        CGFloat num = [x floatValue];
//        if (num == 1) {
//            [self.viewModel.subjectUI sendNext:@(MainViewLoadViewTypeHide)];
//        }
        [self.loadV setStrokeEnd:num animated:YES];
    }];
    
    //绑定进度条
    //    estimatedProgress
//    RAC(self, progressView.progress) =
//    [[self.webView rac_valuesAndChangesForKeyPath:@"estimatedProgress"
//                                          options:NSKeyValueObservingOptionNew
//                                         observer:nil] map:^id(id value) {
//        //          @strongify(self)
//        RACTupleUnpack(NSNumber * item) = value;
//        // item = 0.0 ~ 1.0 表示进度时间
//        return item;
//    }];
    
    
    
//
//    //绑定进度条Hide
//    RAC(self, progressView.hidden) = RACObserve(self, viewModel.ProgressHide);
    
    
    
}

#pragma mark- 生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示导航
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}


#pragma mark- 懒加载

//加载视图
-(LoadView *)loadV
{
    if (!_loadV) {
        _loadV = [[LoadView alloc]initWithFrame:CGRectZero];
        [_loadV setBackgroundColor:[UIColor whiteColor]];
        
       
        
    }
    return _loadV;
}



-(SuperWKWebView *)webView
{
    if (!_webView) {
        
        
        // 创建配置
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // // 创建UserContentController（提供JavaScript向webView发送消息的方法）
        config.userContentController = [[WKUserContentController alloc] init];
        
        //保存cookieScript
        WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: @"document.cookie ='TeskCookieKey1=TeskCookieValue1';document.cookie = 'TeskCookieKey2=TeskCookieValue2';" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        
        [config.userContentController addUserScript:cookieScript];
        _webView = [[SuperWKWebView alloc]initWithFrame:CGRectZero configuration:config];
         _webView.allowsBackForwardNavigationGestures = YES;
        
        //设置代理
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [config.userContentController addScriptMessageHandler:self.viewModel name:MainHandlerMe];
        [_webView setNavigationDelegate:self.viewModel];
        [_webView setUIDelegate:self.viewModel];
        [_webView loadRequestWithUrlString:findURL];
    }
    return _webView;
}

-(MainTabBar *)tabBarView
{
    if (!_tabBarView) {
        @weakify(self)
        _tabBarView = [[MainTabBar alloc]initWithFrame:CGRectZero];
        [_tabBarView setBackgroundColor:[UIColor whiteColor]];
        [_tabBarView.tapSubject subscribeNext:^(id x) {
            @strongify(self)
            MainTabBarType type = [x integerValue];
            
            switch (type) {
                case MainTabBarTypeMessages:
                    [self.webView loadRequestWithUrlString:messagesURL];
                    NSLog(@"消息");
                    break;
                case MainTabBarTypeNews:
                     [self.webView loadRequestWithUrlString:newsURL];
                    NSLog(@"通信录");
                    break;
                case MainTabBarTypeAPP:
                     [self.webView loadRequestWithUrlString:appURL];
                    NSLog(@"APP");
                    break;
                case MainTabBarTypeFind:
                     [self.webView loadRequestWithUrlString:findURL];
                    NSLog(@"发现");
                    break;
                case MainTabBarTypeMe:
                     [self.webView loadRequestWithUrlString:meURL];
                    NSLog(@"我的");
                    break;
                    
                default:
                    break;
            }
            
        }];
    }
    return _tabBarView;
}

-(MainViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[MainViewModel alloc]initWithViewController:self];
        @weakify(self)
        [_viewModel.subjectUI subscribeNext:^(id x) {
            @strongify(self)
            MainViewUIType type = [x integerValue];
            switch (type) {
                case MainViewTabBarTypeHide: //隐藏tabBar
                    [self.tabBarView hideTabBar];
                    break;
                    
                case MainViewTabBarTypeShow: //显示tabBar
                    [self.tabBarView showTabBar];
                    break;
                    
                case MainViewTabBarBtnSelectedTypeMessages: //高亮显示Messages按钮
                    [self.tabBarView mainTabBarSelectedTagNumber:100];
                    break;
                    
                case MainViewTabBarBtnSelectedTypeNews: //高亮显示News按钮
                    [self.tabBarView mainTabBarSelectedTagNumber:101];
                    break;
                    
                case MainViewTabBarBtnSelectedTypeAPP: //高亮显示APP按钮
                    [self.tabBarView mainTabBarSelectedTagNumber:102];
                    break;
                    
                case MainViewTabBarBtnSelectedTypeFind: //高亮显示Find按钮
                    [self.tabBarView mainTabBarSelectedTagNumber:103];
                    break;
                    
                case MainViewTabBarBtnSelectedTypeMe: //高亮显示Me按钮
                    [self.tabBarView mainTabBarSelectedTagNumber:104];
                    break;
                    
                case MainViewLoadViewTypeHide: //隐藏加载视图
                    [self.loadV setHidden:YES];
                    [self.loadV setStrokeEnd:0 animated:YES];
                    break;
                    
                case MainViewLoadViewTypeShow: //显示加载视图
                    [self.loadV setHidden:NO];
                    break;
                    
                default:
                    break;
            }
        }];
    }
    return _viewModel;
}





@end
