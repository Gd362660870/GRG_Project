//
//  LandingViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/29.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "LandingViewModel.h"
#import "LandingView.h"

@interface LandingViewModel()
@property (nonatomic,strong)LandingView *VC;
@end

@implementation LandingViewModel
-(instancetype)initWithViewController:(id)viewController
{
    self = [super init];
    if (self) {
        self.VC = viewController;
        
        
    }
    return self;
}
@end
