//
//  AppViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "AppViewModel.h"
#import "AppView.h"

@interface AppViewModel()
@property (nonatomic,strong)AppView *VC;
@end

@implementation AppViewModel
-(instancetype)initWithViewController:(id)viewController
{
    self = [super init];
    if (self) {
        self.VC = viewController;
       
    }
    return self;
}


@end
