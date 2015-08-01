//
//  UIBarButtonItem+Extension.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(instancetype)initWithBackGroudImage:(NSString *)image highlightedImage:(NSString *)highlightedImage targer:(id)targer action:(SEL)action{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [btn addTarget:targer action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    return  [[self alloc] initWithCustomView:btn];
}

@end
