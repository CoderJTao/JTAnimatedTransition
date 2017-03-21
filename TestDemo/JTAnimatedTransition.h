//
//  JTAnimatedTransition.h
//  TestDemo
//
//  Created by jiangT on 2017/3/7.
//  Copyright © 2017年 jiangT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
    JTAnimatedTransitionTypePush,
    JTAnimatedTransitionTypePop,
    JTAnimatedTransitionTypePresent,
    JTAnimatedTransitionTypeDismiss
}JTAnimatedTransitionType;

@interface JTAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (assign, nonatomic) JTAnimatedTransitionType type;

@property (strong, nonatomic) id transitionContext;

+ (JTAnimatedTransition *)animatedTransitionWithType:(JTAnimatedTransitionType)type;




@end
