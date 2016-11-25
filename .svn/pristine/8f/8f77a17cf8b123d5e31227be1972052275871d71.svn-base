//
//  DownloadViewController.m
//  下载并预览Demo
//
//  Created by 陈家劲 on 16/10/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "DownloadViewController.h"
#import "DownloadViewModel.h"



@interface DownloadViewController ()
//ViewModel
@property (nonatomic,strong)DownloadViewModel *viewModel;

@end

@implementation DownloadViewController


#pragma mark- 初始化
- (instancetype)initWithDownloadURL:(NSString *)URL
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.viewModel updateDownload];
    }
    return self;
}

#pragma mark- 下载URL
- (void)downloadURL:(NSString *)url
{
    
}


#pragma mark- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"本地文件";
    
    //添加视图
    [self addViews];
    
    //适配
    [self defineLayout];
    
    //关联
    [self bindWithViewModel];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}




#pragma mark- 添加视图
-(void)addViews
{
    [self.view addSubview:self.tableView];
}


#pragma mark- 适配
-(void)defineLayout
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark- 关联
-(void)bindWithViewModel
{
    
}

#pragma mark- 懒加载
-(DownloadViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[DownloadViewModel alloc]initWithViewController:self];
    }
    return _viewModel;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setDelegate:self.viewModel];
        [_tableView setDataSource:self.viewModel];
        [_tableView setRowHeight:60];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        
        [_tableView registerNib:[UINib nibWithNibName:@"DownloadTableViewCell" bundle:nil] forCellReuseIdentifier:DownloadCellID];
    }
    return _tableView;
}

@end
