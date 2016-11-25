//
//  CJJ_Tools.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/8/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "CJJ_Tools.h"
#import <objc/runtime.h>
@implementation CJJ_Tools

+(CJJ_Tools *)sharedTools
{
    static CJJ_Tools *tool = nil;
    if (tool == nil) {
        tool = [[super alloc]init];
    }
    return tool;
}


- (void)setTabBarItemWithTitleSize:(CGFloat)size
                       andFoneName:(NSString *)foneName
                   withSelectColor:(UIColor *)selectColor
                 withUnSelectColor:(UIColor *)unselectColor {
    
    if (!foneName) {
        foneName = @"Marion-Italic";
    }
    
  //未选中字体颜色
  [[UITabBarItem appearance] setTitleTextAttributes:@{
    NSForegroundColorAttributeName : unselectColor,
    NSFontAttributeName : [UIFont fontWithName:foneName size:size]
  }
                                           forState:UIControlStateNormal];
  
  //    //选中字体颜色
  [[UITabBarItem appearance] setTitleTextAttributes:@{
    NSForegroundColorAttributeName : selectColor,
    NSFontAttributeName : [UIFont fontWithName:foneName size:size]
  }
                                           forState:UIControlStateSelected];
    
   
    
}


- (void)setTabBarItemWithTitleSize:(CGFloat)size
                       andFoneName:(NSString *)foneName
{
    
    if (!foneName) {
        foneName = @"Marion-Italic";
    }
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        
                                                        NSFontAttributeName : [UIFont fontWithName:foneName size:size]
                                                        }
                                             forState:UIControlStateNormal];
    
    //    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        
                                                        NSFontAttributeName : [UIFont fontWithName:foneName size:size]
                                                        }
                                             forState:UIControlStateSelected];
    
    
}


- (void)properties_aps:(id)item
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([item class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [item valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    NSLog(@"%@",props);
}

#pragma mark- 获取相机授权状态

-(AVAuthorizationStatus)getVideoAuthStatus
{
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    return [AVCaptureDevice authorizationStatusForMediaType:mediaType];
}



#pragma mark- 懒加载
//动画属性
-(CJJ_Animation *)animation
{
    if (!_animation) {
        _animation = [CJJ_Animation new];
    }
    return _animation;
}
@end
