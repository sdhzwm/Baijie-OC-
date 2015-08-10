//
//  WMAddTagController.h
//  百思不得姐
//
//  Created by 王蒙 on 15/8/7.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMAddTagController : UIViewController

@property (nonatomic,copy) void(^tagsBlock)(NSArray *tas);
/**所有的标签*/
@property (nonatomic,strong) NSArray *tags;
@end
