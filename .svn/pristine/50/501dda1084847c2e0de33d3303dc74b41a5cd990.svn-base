//
//  UIButton+Type.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/19.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "UIButton+Type.h"

@implementation UIButton (Type)
//
//-(void)setSelected:(BOOL)selected
//{
//    [super setSelected:selected];
//    
//}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    
}
-(void)tabBarButtonAnimation
{
    self.userInteractionEnabled = NO;
    POPSpringAnimation *Animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    Animation.velocity = [NSValue valueWithCGSize:CGSizeMake(10, 10)];
    Animation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    Animation.springBounciness = 20;
    Animation.springSpeed = 10;
    //        Animation.autoreverses = YES; //自动反向
    [Animation setCompletionBlock:^(POPAnimation *asd, BOOL is  ) {
        self.userInteractionEnabled = YES;
    }];
    [self.layer pop_addAnimation:Animation forKey:@"LayerScaleXY"];
    
    POPSpringAnimation *rotationAnimation = [POPSpringAnimation animation];
    rotationAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerRotation];
    rotationAnimation.springBounciness = 20;
    rotationAnimation.springSpeed = 20;
    rotationAnimation.velocity = @(10);
    rotationAnimation.toValue= @(0); //2 M_PI is an entire rotation
    [self.layer pop_addAnimation:rotationAnimation forKey:@"LayerRotation"];
    [self.layer removeAllAnimations];

}

-(void)NACBarButton_Home_Animation
{
    [self setUserInteractionEnabled:NO];
    POPSpringAnimation *positionXAnimation = [POPSpringAnimation animation];
    positionXAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerPositionX];
    positionXAnimation.springBounciness = 20;
    positionXAnimation.springSpeed = 10;
    positionXAnimation.velocity = @(500);
    
    [positionXAnimation setCompletionBlock:^(POPAnimation *animation, BOOL is) {
        [self setUserInteractionEnabled:YES];
    }];
    
    [self.layer pop_addAnimation:positionXAnimation forKey:@"LayerRotation"];
    
    [self.layer removeAllAnimations];
    
}

@end
