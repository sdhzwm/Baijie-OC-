//
//  WMTabBar.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMTabBar.h"
#import "WMPublishViewController.h"
@interface WMTabBar()
/**按钮*/
@property (nonatomic,weak) UIButton *pushBtn;
@end
@implementation WMTabBar

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
       
        [btn addTarget:self action:@selector(pushlishVC) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        self.pushBtn = btn;
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    }
    return  self;
}

- (void)pushlishVC{
    WMPublishViewController *pushlish = [[WMPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pushlish animated:YES completion:nil];

}
- (void)layoutSubviews{

    [super layoutSubviews];
    
    static BOOL isClick = NO;
    //对按钮进行布局
    CGSize btnWH = self.pushBtn.currentBackgroundImage.size;
    CGSize tabBarWH = self.frame.size;
    self.pushBtn.height = btnWH.height;
    self.pushBtn.width = btnWH.width;
    self.pushBtn.center = CGPointMake(tabBarWH.width*0.5, tabBarWH.height*0.5);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = tabBarWH.width / 5;
    CGFloat buttonH = tabBarWH.height;
    NSInteger index = 0;
    //对子控件进行布局
    for (UIControl *btn in self.subviews) {
        if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
        
        if (isClick == NO) {
            
            [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    isClick = YES;
}

//发送通知
- (void)onClick{

    [[NSNotificationCenter defaultCenter] postNotificationName:WMTabBarDidSelectNotification object:nil userInfo:nil];
}

@end
