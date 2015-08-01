//
//  WMFriendTrendsController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMFriendTrendsController.h"
#import "WMRecommendController.h"
#import "WMLoginController.h"
@interface WMFriendTrendsController ()

@end

@implementation WMFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [UIBarButtonItem initWithBackGroudImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" targer:self action:@selector(onClick)];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.title = @"我的关注";
}

- (void)onClick{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Recommend" bundle:nil];
    
    WMRecommendController *rvc = sb.instantiateInitialViewController;
    
    [self.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)loginModel:(id)sender {
    
    WMLoginController *login = [[WMLoginController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
   
}



@end
