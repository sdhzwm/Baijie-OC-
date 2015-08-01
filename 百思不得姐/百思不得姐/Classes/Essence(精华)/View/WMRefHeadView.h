//
//  WMRefHeadView.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/24.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMRefHeadView;

@protocol RefHeadViewDelegate<NSObject>
@optional

- (void)headView:(WMRefHeadView *)refHead didOnclick:(UIButton*)btn;

@end

@interface WMRefHeadView : UIView
+ (instancetype)refHeadView;
/**按钮的状态*/
@property (nonatomic,copy) NSString *state;

/**block*/
@property (nonatomic,weak) id<RefHeadViewDelegate> delegate;
@end
