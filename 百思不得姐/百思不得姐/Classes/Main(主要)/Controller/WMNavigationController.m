//
//  WMNavigationController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMNavigationController.h"

@implementation WMNavigationController


+(void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad{
    [super viewDidLoad];
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
