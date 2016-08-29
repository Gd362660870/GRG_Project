//
//  CJJ_NetWork.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "CJJ_NetWork.h"

@interface CJJ_NetWork()

@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;
@end

@implementation CJJ_NetWork

+(CJJ_NetWork *)sharedCNetWork
{
    static CJJ_NetWork *netWork = nil;
    if (netWork == nil) {
        netWork = [[super alloc]init];
    }
    return netWork;
}

-(AFHTTPRequestOperationManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer new];
       
    }
    return _manager;
}

@end
