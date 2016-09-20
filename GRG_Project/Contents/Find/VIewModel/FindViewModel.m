//
//  FindViewModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "FindViewModel.h"
#import "FindView.h"

@interface FindViewModel()
@property (nonatomic,strong)FindView *viewC;
@end

@implementation FindViewModel
-(instancetype)initWithViewController:(id)viewController
{
    self = [super init];
    if (self) {
        self.viewC = viewController;
        
    }
    return self;
}



@end
