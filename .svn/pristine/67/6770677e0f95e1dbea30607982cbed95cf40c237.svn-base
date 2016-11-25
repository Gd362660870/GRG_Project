//
//  DownloadViewModel.m
//  下载并预览Demo
//
//  Created by 陈家劲 on 16/10/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "DownloadTableViewCell.h"
#import "DownloadViewController.h"
#import "DownloadViewModel.h"
#import "DownloadModel.h"
#import "CJJ_PreviewController.h"
#import "UIButton+Type.h"

@interface DownloadViewModel ()

@property(nonatomic, weak) DownloadViewController *view;
@property(nonatomic, strong) NSString *downloadURL;
@property (nonatomic,strong)DownloadModel *model;

/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation DownloadViewModel

#pragma mark - 初始化

- (instancetype)initWithViewController:(id)controller {
  self = [super init];
  if (self) {
    self.view = controller;
  }
  return self;
}

#pragma mark - 更新下载文件
-(void)updateDownload
{
    
}

#pragma mark - UITableViewDataSource

//选中某一行执行的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      NSArray *arrayURL= @[@"http://seugs.seu.edu.cn/_upload/article/79/ab/bf5c2282438ab092985e40df301a/0d94041b-a939-4924-92d0-40ef659a6d7d.doc",@"https://raw.githubusercontent.com/appcoda/QuickLookDemo/master/QuickLookDemoStarter.zip",@"http://boscdn.bpc.baidu.com/channelpush/sdk/BPush-SDK-iOS-1.4.7.zip"];
    if (indexPath.row == 0) {
      
        self.dataArray = [self.model downloadFileURL:arrayURL[0]];
    }else if (indexPath.row == 1)
    {
       self.dataArray =  [self.model downloadFileURL:arrayURL[1]];
    }else if (indexPath.row == 2)
    {
         self.dataArray = [self.model downloadFileURL:arrayURL[2]];
    }
    
    [self.view.tableView reloadData];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //复用cell
  __block DownloadTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:DownloadCellID];
  if (cell == nil) {
    cell = [[DownloadTableViewCell alloc]
          initWithStyle:UITableViewCellStyleSubtitle
        reuseIdentifier:DownloadCellID];
  }
    
    //导入模型
    [cell updateDataItem:self.dataArray[indexPath.section][indexPath.row]];
    
    //按钮事件回调
    [cell.btnFace buttonBlockControlEvents:UIControlEventTouchUpInside endMyBlock:^(UIButton *x) {
        if ([x.titleLabel.text isEqualToString:@"打开"]) {
                        //打开按钮
            
                        CJJ_PreviewController *previewC = [[CJJ_PreviewController alloc]init];
                        previewC.filePath_URL = cell.filePath_URL;
                        previewC.title = cell.fileName;
                        [self.view.navigationController pushViewController:previewC animated:YES];
                    }else
                    {
                        //继续按钮
                        [cell.downloadModel.subjectDownloadStatus sendNext:@(DownloadStatusStart)];
                    }

    }];
  return cell;
}


//返回表格的分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

//返回每一个分组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray[section] count];
}

//返回分组头部显示的标题的方法
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = nil;
    switch (section) {
        case 0:
            str = @"下载文件";
            break;
            
        case 1:
            str = @"本地文件";
            break;
            
        case 2:
            str = @"什么鬼";
            break;
            
        default:
            break;
    }
    if (!str) {
        str = @"什么鬼？？？？？？";
    }
    return str;
}

//返回表格的编辑方式的方法
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

//只要重写了该方法,表格处于可以编辑的状态的时候 就可以移动cell了
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSLog(@"%s",__func__);
}


// 实现系统默认的左滑删除功能
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete://删除
            
            [self.model deleteFile:indexPath];

            break;
            
        case UITableViewCellEditingStyleInsert://插入
            
            break;
            
        case UITableViewCellEditingStyleNone: //无
            
            break;
            
        default:
            break;
    }
    
    
    

}




#pragma mark- dealloc
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark- 懒加载
-(DownloadModel *)model
{
    if (!_model) {
        _model = [DownloadModel sharedCNetDownloadModel];
        
        //接受更新信号
        @weakify(self)

//        deliverOn:[RACScheduler mainThreadScheduler]
        [_model.subjectReloadData  subscribeNext:^(id x) {
            @strongify(self)
            
            
      
                
                NSMutableArray *marray = x[@"dataArray"];
                self.dataArray = marray;
//                NSLog(@"%@",x);
                // 局部刷新
                //
                //获取一个主队列
                //创建一个并行多线程
            if (x[@"delete"]!= nil) {
                [self.view.tableView deleteRowsAtIndexPaths:@[x[@"delete"]]withRowAnimation: UITableViewRowAnimationBottom];
            }
            if (x[@"insert"]!= nil) {
                [self.view.tableView insertRowsAtIndexPaths:@[x[@"insert"]] withRowAnimation:UITableViewRowAnimationTop];
            }
  
            
        }];
        
    }
    return _model;
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [self.model updateFile];
    }
    return _dataArray;
}

@end
