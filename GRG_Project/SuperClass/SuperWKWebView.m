//
//  SuperWKWebView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/9/8.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "SuperWKWebView.h"

@implementation SuperWKWebView



- (instancetype)initWithFrame:(CGRect)frame configuration:(nonnull WKWebViewConfiguration *)configuration
{
   
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        
//        //设置滚动视图内容距离
//        [self.scrollView setContentInset:UIEdgeInsetsMake(NavigationBar_Height_2, 0, 0, 0)];
        
//
//        //滚动指标插图从滚动视图边缘的距离。
//        [self.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, TabBar_Height_1, 0)];
        
        
        
    }
    return self;
}


#pragma mark- dealloc
- (void)dealloc {
    [self.configuration.userContentController
     removeScriptMessageHandlerForName:MainHandlerMe];
}


- (void)loadRequestWithUrlString:(NSString *)urlString {
    
    
    NSMutableString *cookieStr = [[NSMutableString alloc] init];
    NSArray *array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:urlString]];
    if ([array count] > 0) {
        for (NSHTTPCookie *cookie in array) {
            [cookieStr appendFormat:@"%@=%@;",cookie.name,cookie.value];
        }
        //删除最后一个分号 “；”
        [cookieStr deleteCharactersInRange:NSMakeRange(cookieStr.length - 1, 1)];
    }
    
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [myRequest addValue:cookieStr forHTTPHeaderField:@"Cookie"];
   
    [self loadRequest:myRequest];
    
}



@end
