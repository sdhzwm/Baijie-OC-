//
//  WMNavigationController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMNavigationController.h"

@interface WMNavigationController() <UIGestureRecognizerDelegate>

@end
@implementation WMNavigationController


+(void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    UIBarButtonItem *bar = [UIBarButtonItem appearance];
    
    NSMutableDictionary *arrDict = [NSMutableDictionary dictionary];
    arrDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    arrDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [bar setTitleTextAttributes:arrDict forState:UIControlStateNormal];
    
    NSMutableDictionary *disDict = [NSMutableDictionary dictionary];

    disDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [bar setTitleTextAttributes:disDict forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
}

//- (void)viewDidAppear:(BOOL)animated{
//
//    //设置滑动回退
//    __weak typeof(self) weakSelf = self;
//    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
//    //判断是否为第一个view
//    if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
//}

#pragma mark - 手势代理方法
// 是否开始触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 判断下当前控制器是否是跟控制器
    
    return (self.topViewController != [self.viewControllers firstObject]);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
       
        [btn sizeToFit];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        btn.size = CGSizeMake(60, 35);
//        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);

        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



- (void)onClick{
    [self popViewControllerAnimated:YES];
}
@end
