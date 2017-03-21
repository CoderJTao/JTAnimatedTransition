//
//  ViewControllerTwo.m
//  TestDemo
//
//  Created by jiangT on 2017/3/7.
//  Copyright © 2017年 jiangT. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "JTAnimatedTransition.h"

@interface ViewControllerTwo ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.delegate = self;
    self.title = @"详情";
    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width/2, self.view.bounds.size.width/2)];
    _imageView.center = CGPointMake(self.view.bounds.size.width/2, 200);
    _imageView.image = self.img;
    [self.view addSubview:_imageView];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"回去" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}

-(void)back
{
    NSLog(@"回去");
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame = _fromFrame;
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

//
//#pragma mark - pop / push
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    
//    if (operation == UINavigationControllerOperationPop) {
//        JTAnimatedTransition *animatedTransition = [JTAnimatedTransition animatedTransitionWithType:JTAnimatedTransitionTypePop];
//        return animatedTransition;
//    }
//    return nil;
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (viewController != self) {
//        self.imageView.frame = CGRectNull;
//    }
//}



@end
