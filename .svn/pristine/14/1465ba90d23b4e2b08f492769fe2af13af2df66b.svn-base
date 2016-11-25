
//
//  ScannerModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/10.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "ScannerModel.h"

@implementation ScannerModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark- 懒加载
-(NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = @[@"icon-6",@"icon-8",@"icon-9"];
    }
    return _imageArray;
}

-(NSArray *)imageNameArray
{
    if (!_imageNameArray) {
        _imageNameArray = @[@"首页",@"闪光灯",@"相册",];
    }
    return _imageNameArray;
}
@end
