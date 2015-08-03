//
//  UIImage+WMExtension.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/3.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "UIImage+WMExtension.h"

@implementation UIImage (WMExtension)

- (UIImage *)roundImage{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height    );
    CGContextAddEllipseInRect(ref, rect);
    //裁剪
    CGContextClip(ref);
    //会上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}
@end
