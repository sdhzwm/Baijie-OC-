//
//  WMNewController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMNewController.h"

@interface WMNewController ()

@end

@implementation WMNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    UIBarButtonItem *item = [UIBarButtonItem initWithBackGroudImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" targer:self action:@selector(onClick)];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)onClick{
    
}
@end
