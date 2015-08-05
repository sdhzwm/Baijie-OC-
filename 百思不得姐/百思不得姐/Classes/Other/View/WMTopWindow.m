//
//  WMTopWindow.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/4.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMTopWindow.h"

@implementation WMTopWindow
static UIWindow *window_;

+ (void)initialize{
    
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, WMScreenW, 20);
  
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchScrollView)]];
}

+ (void)show{
    window_.hidden = NO;
}

+ (void)searchScrollView{
    //获取当前的windows
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //查找当前window下的ScrollView
    [WMTopWindow searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView*)superView{
    
    for(UIScrollView *view in superView.subviews){
        if ([view isKindOfClass:[UIScrollView class]]&&view.isShowingOnKeyWindow) {
            //获取子空间的偏移量
            CGPoint offset = view.contentOffset;
            offset.y = -view.contentInset.top;
            [view setContentOffset:offset animated:YES];
        }
        [WMTopWindow searchScrollViewInView:view];
    }
    
}
@end
