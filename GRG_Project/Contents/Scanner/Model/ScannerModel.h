//
//  ScannerModel.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/10.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScannerModel : NSObject
/**
 *  数组：存储图片路径
 */
@property (nonatomic,strong)NSArray *imageArray;
/**
 *  数组：存储图片名字
 */
@property (nonatomic,strong)NSArray *imageNameArray;
@end
