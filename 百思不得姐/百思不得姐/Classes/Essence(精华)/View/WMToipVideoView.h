//
//  WMToipVoiceView.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/31.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMWordToip;
@interface WMToipVideoView : UIView
/**模型*/
@property (nonatomic,strong) WMWordToip *wordToip;
+ (instancetype)initWithToipVoicView;
@end
