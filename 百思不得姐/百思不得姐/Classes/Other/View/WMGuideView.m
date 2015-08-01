//
//  WMGuideView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/26.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMGuideView.h"
@interface WMGuideView()

@end
@implementation WMGuideView
#pragma mark - 初始化方法
+ (void)showGuideView{

    
    NSString *key = @"CFBundleShortVersionString";
    //获取当前的版本号
    NSString *currVission = [NSBundle mainBundle].infoDictionary[key];
    //获取沙盒中的版本好
    NSString *sanboxVerssion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currVission isEqualToString:sanboxVerssion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        WMGuideView *guideView = [WMGuideView initGuideView];
        
        guideView.frame = window.bounds;
        
        [window addSubview:guideView];
        //  将版本号baoc
        [[NSUserDefaults standardUserDefaults] setValue:currVission forKey:key];
        //理解保存到沙盒中
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


+ (instancetype)initGuideView{

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];

}

- (IBAction)closeBtn:(id)sender {
    [self removeFromSuperview];
}

@end
