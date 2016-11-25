//
//  CJJ_PreviewViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/11/15.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "CJJ_PreviewViewModel.h"
#import "CJJ_PreviewModel.h"

@interface CJJ_PreviewViewModel()

//数据源
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CJJ_PreviewViewModel

#pragma mark- QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    CJJ_PreviewModel *model = [[CJJ_PreviewModel alloc]init];

    model.previewItemURL = self.filePath_URL;
    model.previewItemTitle = @"哈哈哈哈哈";
    return model;
}
#pragma mark- 懒加载
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        
        
    }
    return _dataArray;
}


@end
