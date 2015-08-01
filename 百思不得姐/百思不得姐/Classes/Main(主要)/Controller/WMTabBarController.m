//
//  WMTabBarController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMTabBarController.h"
#import "WMEssenceController.h"
#import "WMFriendTrendsController.h"
#import "WMMeController.h"
#import "WMNewController.h"
#import "WMTabBar.h"
#import "WMNavigationController.h"
@interface WMTabBarController ()

@end

@implementation WMTabBarController


+ (void)initialize{

    NSMutableDictionary *arrText = [NSMutableDictionary dictionary];
    arrText[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    arrText[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selText = [NSMutableDictionary dictionary];
    selText[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selText[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:arrText forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:selText forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpVCTitle];
}

- (void)setUpVCTitle{

    [self setUpChildVC:[[WMEssenceController alloc] init] image:[UIImage imageNamed:@"tabBar_essence_icon"] selImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    [self setUpChildVC:[[WMNewController alloc] init] image:[UIImage imageNamed:@"tabBar_new_icon"] selImage:[UIImage imageNamed:@"tabBar_new_click_icon"] title:@"新帖"];
    
    
    [self setUpChildVC:[[WMFriendTrendsController alloc] init] image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    
    [self setUpChildVC:[[WMMeController alloc] init] image:[UIImage imageNamed:@"tabBar_me_icon"] selImage:[UIImage imageNamed:@"tabBar_me_click_icon"] title:@"我"];
    
    //替换tabBar
    [self setValue:[[WMTabBar alloc] init] forKeyPath:@"tabBar"];

}

#pragma mark - 设置切换控制器
- (void)setUpChildVC:(UIViewController*)vc image:(UIImage*)image selImage:(UIImage*)selImage title:(NSString*)title{
   
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;    
    vc.tabBarItem.selectedImage = selImage;
    
    WMNavigationController *nvc = [[WMNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nvc];
     vc.view.backgroundColor = WMGlobalBg;
}


#pragma mark - 随机色

- (UIColor*)RandomColor{
    CGFloat hue = arc4random_uniform(100) / 100.0;
    CGFloat saturation = arc4random_uniform(100) / 100.0 + 0.5;
    CGFloat brightness = arc4random_uniform(100) / 100.0 + 0.5;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

@end
