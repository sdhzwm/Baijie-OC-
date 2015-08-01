//
//  UIBarButtonItem+Extension.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(instancetype)initWithBackGroudImage:(NSString*)image highlightedImage:(NSString*)highlightedImage targer:(id)targer action:(SEL)action;
@end
