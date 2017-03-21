//
//  ViewController.m
//  TestDemo
//
//  Created by jiangT on 2017/3/7.
//  Copyright © 2017年 jiangT. All rights reserved.
//

#import "ViewController.h"
#import "JTAnimatedTransition.h"
#import "ViewControllerThree.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, weak) UIImageView *selectImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.navigationController.delegate = self;
    self.transitioningDelegate = self;
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIImageView *selectImageView = [UIImageView new];
    selectImageView.frame = CGRectNull;
    [self.view addSubview:selectImageView];
    self.selectImageView = selectImageView;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    [btn setTitle:@"模态" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

-(void)click:(UIButton *)sender
{
    ViewControllerThree *vc = [[ViewControllerThree alloc]init];
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mine_logo%ld.png",indexPath.row%6+1]];
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行",indexPath
                           .row+1];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ViewControllerTwo *vc = [[ViewControllerTwo alloc]init];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    cell.imageView.hidden = YES;
    self.selectImageView.image = cell.imageView.image;
    self.selectImageView.frame = CGRectMake(cell.imageView.frame.origin.x, rect.origin.y, cell.imageView.frame.size.width, cell.imageView.frame.size.height);

    vc.img = self.selectImageView.image;
    vc.fromFrame = self.selectImageView.frame;
    [UIView animateWithDuration:0.5 animations:^{
        self.selectImageView.frame = CGRectMake(0, 2, self.view.bounds.size.width/2, self.view.bounds.size.width/2);
        self.selectImageView.center = CGPointMake(self.view.bounds.size.width/2, 200);
    } completion:^(BOOL finished) {
    [self.navigationController pushViewController:vc animated:YES];
        
        }];
}


#pragma mark - pop / push
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        JTAnimatedTransition *animatedTransition = [JTAnimatedTransition animatedTransitionWithType:JTAnimatedTransitionTypePush];
        return animatedTransition;
    }
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != self) {
        self.selectImageView.frame = CGRectNull;
        
        NSArray *cellArr = [self.tableView visibleCells];
        for (UITableViewCell *cell in cellArr) {
            cell.imageView.hidden = NO;
        }
        
    }
}


#pragma mark - present / dismiss
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [JTAnimatedTransition animatedTransitionWithType:JTAnimatedTransitionTypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [JTAnimatedTransition animatedTransitionWithType:JTAnimatedTransitionTypeDismiss];
}


@end
