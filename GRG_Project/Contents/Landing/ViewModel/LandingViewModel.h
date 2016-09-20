//
//  LandingViewModel.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/29.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "SuperViewModel.h"
@interface LandingViewModel : SuperViewModel<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic,strong)RACSignal *loadingSingl;
@property(nonatomic,strong)RACSignal *titleSingl;
@property(nonatomic,strong)RACSignal *estimatedProgressSingl;
@property(nonatomic,strong)NSNumber *loading;

@end
