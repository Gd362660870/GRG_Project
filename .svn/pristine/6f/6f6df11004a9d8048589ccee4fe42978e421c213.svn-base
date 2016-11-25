//
//  UserModel.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        //获取用户信息
        [self getUsInformation];
        [self AddCookie];
        
    }
    return self;
}
#pragma mark-获取用户信息
-(void)getUsInformation
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"%@",infoDictionary);

    //手机别名： 用户定义的名称
    self.userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", self.userPhoneName);
    //设备名称
    self.deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",self.deviceName );
    //手机系统版本
    self.phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", self.phoneVersion);
    //手机型号
    self.phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",self.phoneModel );
    //地方型号  （国际化区域名称）
    self.localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",self.localPhoneModel );
    
    // 当前应用名称
    self.appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"当前应用名称：%@",self.appCurName);
    // 当前应用软件版本  比如：1.0.1
    self.appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",self.appCurVersion);
    // 当前应用版本号码   int类型
    self.appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",self.appCurVersionNum);
}


#pragma mark- 设置cookie

-(void)deleteCookie
{
    //清空Cookie
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in  [myCookie cookies])
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    //删除沙盒自动生成的Cookies.binarycookies文件
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:@"/Library/Cookies/Cookies.binarycookies"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:filePath error:nil];
}
-(void)AddCookie
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *nCookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *cookiesURL = [nCookies cookiesForURL:[NSURL URLWithString:yunBaiDu]];  //这个是主页的url，不是登录页的url
    NSArray *cookiesURL = nCookies.cookies;
    
//    for (NSHTTPCookie *name in cookiesURL) {
//        NSLog(@"NSHTTPCookie------------->%@",name.name);
//    }
    
    
    for (id c in cookiesURL)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]])
        {
            cookie=(NSHTTPCookie *)c;
//            NSLog(@"name---------->%@",cookie.name);
//            if ([cookie.name isEqualToString:@".UmanyiClentCookies"]) {//我的cookies的名字是 "PHPSESSID"，你在上一行打个断点看看你的cookies的name是什么
            if (1){
                NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*30*12];//当前点后，保存一年左右
                NSArray *cookies = [NSArray arrayWithObjects:cookie.name, cookie.value, expiresDate, cookie.domain, cookie.path, nil];
                
                if(cookies){
                    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
                    [cookieProperties setObject:[cookies objectAtIndex:0] forKey:NSHTTPCookieName];
                    [cookieProperties setObject:[cookies objectAtIndex:1] forKey:NSHTTPCookieValue];
                    [cookieProperties setObject:[cookies objectAtIndex:2] forKey:NSHTTPCookieExpires];
                    [cookieProperties setObject:[cookies objectAtIndex:3] forKey:NSHTTPCookieDomain];
                    [cookieProperties setObject:[cookies objectAtIndex:4] forKey:NSHTTPCookiePath];
                    
                    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
                    [[NSHTTPCookieStorage sharedHTTPCookieStorage]  setCookie:cookieuser];
                }
                break;
            }
        }
    }
}
@end
