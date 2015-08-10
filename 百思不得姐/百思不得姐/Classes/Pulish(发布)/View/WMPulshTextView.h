//
//  WMPulshTextView.h
//  百思不得姐
//
//  Created by 王蒙 on 15/8/5.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMPulshTextView : UITextView
/**占位字符*/
@property (nonatomic,copy) NSString *placeholder;
/**占位文字颜色*/
@property (nonatomic,strong) UIColor *placeholderColor;
@end
