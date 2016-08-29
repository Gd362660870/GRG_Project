//
//  CJJ_NetWork.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
@interface CJJ_NetWork : NSObject
/**
 *  单例创建NetWork对象
 *
 *  @return 返回一个实例对象
 */
+(CJJ_NetWork *)sharedCNetWork;

@end
