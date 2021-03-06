//
//  UIImageView+Scanner.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/10.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "UIImageView+Scanner.h"
#import <objc/runtime.h>
@implementation UIImageView (Scanner)



-(void)setType:(UIImageViewScannerType)type
{
    objc_setAssociatedObject(self, @selector(type), @(type), OBJC_ASSOCIATION_ASSIGN);
}

-(UIImageViewScannerType)type
{
    return [objc_getAssociatedObject(self, @selector(type))integerValue];
}

-(void)setTitle:(NSString *)title
{
    objc_setAssociatedObject(self, @selector(title), title,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)title
{
    return objc_getAssociatedObject(self, @selector(title));
}
@end
