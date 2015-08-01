//
//  WMMeController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMMeController.h"


@interface WMMeController ()

@end

@implementation WMMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *moon = [UIBarButtonItem initWithBackGroudImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" targer:self action:@selector(moon)];
    UIBarButtonItem *setting = [UIBarButtonItem initWithBackGroudImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" targer:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItems = @[setting,moon];
    self.title = @"我的";
    
}

- (void)moon{
    NSLog(@"%@",@"哈哈");
    
}
- (void)setting{
    NSLog(@"%@",@"哈哈");
    
}

@end
