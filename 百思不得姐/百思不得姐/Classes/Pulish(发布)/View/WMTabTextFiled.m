//
//  WMTagTextFiled.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/8.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMTabTextFiled.h"

@implementation WMTabTextFiled

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.height               = 30;
        self.font                 = [UIFont systemFontOfSize:16];
        self.placeholder          = @"多个标签用逗号或者换行隔开";
        self.clearsOnBeginEditing = YES;
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}


- (void)deleteBackward{

    !self.delegateBlock ? :self.delegateBlock();
    [super deleteBackward];
}
@end
