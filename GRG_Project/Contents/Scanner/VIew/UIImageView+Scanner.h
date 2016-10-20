//
//  UIImageView+Scanner.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/10.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger,UIImageViewScannerType){
    UIImageViewScannerTypeReturn = 0,//返回
    UIImageViewScannerTypeSpark,//闪光灯
    UIImageViewScannerTypePrint,//照片
};

@interface UIImageView (Scanner)
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)UIImageViewScannerType type;
//@property (nonatomic,assign)
@end
