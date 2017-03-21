//
//  ViewControllerThree.m
//  TestDemo
//
//  Created by jiangT on 2017/3/7.
//  Copyright © 2017年 jiangT. All rights reserved.
//

#import "ViewControllerThree.h"
#import "JTAnimatedTransition.h"
@interface ViewControllerThree ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewControllerThree

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transitioningDelegate = self;
    
    self.title = @"模态";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点我返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [JTAnimatedTransition animatedTransitionWithType:JTAnimatedTransitionTypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [JTAnimatedTransition animatedTransitionWithType:JTAnimatedTransitionTypeDismiss];
}


@end
