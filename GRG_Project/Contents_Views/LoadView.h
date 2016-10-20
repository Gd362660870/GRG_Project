//
//  LoadView.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/17.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadView : UIView

@property(nonatomic) UIColor *strokeColor;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
