//
//  SuperViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "SuperViewModel.h"
#import "SuperVC.h"

@interface SuperViewModel()

@end

@implementation SuperViewModel
-(instancetype)initWithViewController:(id)viewController
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


-(AppDelegate *)appDelegate
{
    if (!_appDelegate) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}


@end
