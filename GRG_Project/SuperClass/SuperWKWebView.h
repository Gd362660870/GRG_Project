//
//  SuperWKWebView.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/9/8.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface SuperWKWebView : WKWebView

/**
 *  本地读取
 *
 *  @param documentName 文件名字
 *  @param webView      Web视图
 */
-(void)loadDocument:(NSString *)documentName inView:(WKWebView *)webView;

- (void)loadRequestWithUrlString:(NSString *)urlString;
@end
