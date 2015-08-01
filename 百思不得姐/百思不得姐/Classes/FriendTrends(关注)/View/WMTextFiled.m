//
//  WMTextFiled.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/26.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMTextFiled.h"

@implementation WMTextFiled

- (void)awakeFromNib{
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

//当前文本框聚焦时就会调用
- (BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:@"placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
//失去焦点就会被调用
- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
