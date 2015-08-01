//
//  WMProgressView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/30.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMProgressView.h"

@implementation WMProgressView

- (void)awakeFromNib{
    //设置圆角
    self.roundedCorners = 2;
    //设置字体颜色
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    NSString *progressNuber = [NSString stringWithFormat:@"%.1f%%",progress*100];
    self.progressLabel.text = [progressNuber stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
