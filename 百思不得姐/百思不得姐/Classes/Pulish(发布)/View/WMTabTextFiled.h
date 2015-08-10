//
//  WMTagTextFiled.h
//  百思不得姐
//
//  Created by 王蒙 on 15/8/8.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMTabTextFiled : UITextField
/**删除按钮的回调*/
@property (nonatomic,copy) void(^delegateBlock)();
@end
