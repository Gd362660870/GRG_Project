//
//  LoadView.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/17.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "LoadView.h"

@interface LoadView()
@property(nonatomic) CAShapeLayer *circleLayer;
- (void)addCircleLayer;
- (void)animateToStrokeEnd:(CGFloat)strokeEnd;
@end

@implementation LoadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.circleLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.circleLayer];
        
       
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.circleLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
     [self addCircleLayer];
    
}

#pragma mark - 实例方法

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
    self.circleLayer.strokeEnd = strokeEnd;
}

#pragma mark - 属性设置

- (void)setStrokeColor:(UIColor *)strokeColor
{
    self.circleLayer.strokeColor = strokeColor.CGColor;
    _strokeColor = strokeColor;
}

#pragma mark - 私有实例方法

- (void)addCircleLayer
{
    //线宽
    CGFloat lineWidth = 10;
    //半径
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2;
    //比例
    CGFloat slider = 0.4;
    
    CGFloat w = radius * 2*slider;
    CGFloat h = w;
    CGFloat x = (CGRectGetWidth(self.bounds) - w)/2;
    CGFloat y = (CGRectGetHeight(self.bounds) - h)/2;
    //rect
    CGRect rect = CGRectMake(x,y,w,h);
    //路径
    self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                       cornerRadius:radius].CGPath;
    
    
    //画笔颜色
    self.circleLayer.strokeColor = MAIN_COLOR.CGColor;
    //填充颜色
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineJoinRound;
    //行程结束
    self.circleLayer.strokeEnd = 0;
    
}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd
{
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.springBounciness = 20;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
    
#if 0
    POPSpringAnimation *colorAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeColor];

    colorAnimation.toValue= [UIColor colorWithRed:arc4random()%255/255.0 green:130/255.0 blue:130/255.0 alpha:1];
    colorAnimation.springBounciness = 20;
//    colorAnimation.springSpeed = 1;
    [self.circleLayer pop_addAnimation:colorAnimation forKey:@"LayerBackgroundColor"];
    
#elif 0
    POPSpringAnimation *colorAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    [UIColor colorWithRed:0.525 green:0.533 blue:0.537 alpha:1.000];
    colorAnimation.toValue= @(arc4random()%10/10.f);
    colorAnimation.springBounciness = 20;
    //    colorAnimation.springSpeed = 1;
    [self.circleLayer pop_addAnimation:colorAnimation forKey:@"kPOPLayerOpacity"];
#endif
    
    
}


@end
