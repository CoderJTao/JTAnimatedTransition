//
//  JTAnimatedTransition.m
//  TestDemo
//
//  Created by jiangT on 2017/3/7.
//  Copyright © 2017年 jiangT. All rights reserved.
//

#import "JTAnimatedTransition.h"



@implementation JTAnimatedTransition

+ (JTAnimatedTransition *)animatedTransitionWithType:(JTAnimatedTransitionType)type
{
    JTAnimatedTransition *animatedTransition = [[JTAnimatedTransition alloc] init];
    animatedTransition.type = type;
    return animatedTransition;
}


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    //返回动画执行的时间
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //设置动画
    self.transitionContext = transitionContext;
    
    if (self.type == JTAnimatedTransitionTypePush) {
        
        // 获得即将消失的vc的v
        UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        // 获得即将出现的vc的v
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        // 获得容器view
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:fromeView];
        [containerView addSubview:toView];
        
        UIBezierPath *startBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((containerView.frame.size.width-100)/2, 100, 100, 100)];
        CGFloat radius = 1000;
        UIBezierPath *finalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(150 - radius, 150 -radius, radius*2, radius*2)];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = finalBP.CGPath;
        toView.layer.mask = maskLayer;
        
        //执行动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.delegate = self;
        animation.fromValue = (__bridge id _Nullable)(startBP.CGPath);
        animation.toValue = (__bridge id _Nullable)(finalBP.CGPath);
        animation.duration = [self transitionDuration:transitionContext];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [maskLayer addAnimation:animation forKey:@"path"];
        
    } else if (self.type == JTAnimatedTransitionTypePresent) {
        
        UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:fromeView];
        [containerView addSubview:toView];
        
        fromeView.frame = containerView.frame;
        toView.frame = containerView.frame;
        
        toView.layer.anchorPoint = CGPointMake(0.0f, 1.0f);
        toView.frame = containerView.frame;
        toView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self.transitionContext completeTransition:YES];
        }];
        
    } else if (self.type == JTAnimatedTransitionTypeDismiss) {
        
        UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:fromeView];
        [containerView addSubview:toView];
        
        fromeView.frame = containerView.frame;
        toView.frame = CGRectMake(containerView.frame.size.width, containerView.frame.origin.y, 0, containerView.frame.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromeView.frame = CGRectMake(containerView.frame.origin.x, containerView.frame.origin.y, 0, containerView.frame.size.height);
            toView.frame = containerView.frame;
        } completion:^(BOOL finished) {
            [self.transitionContext completeTransition:YES];
        }];
        
    } else {
        
    }
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //告诉系统转场动画完成
    [self.transitionContext completeTransition:YES];
    
    //清除相应控制器视图的mask
    [self.transitionContext viewForKey:UITransitionContextFromViewKey].layer.mask = nil;
    [self.transitionContext viewForKey:UITransitionContextToViewKey].layer.mask = nil;
}


@end
