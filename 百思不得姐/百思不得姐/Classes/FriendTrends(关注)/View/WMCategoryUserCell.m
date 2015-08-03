//
//  WMCategoryUserCell.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/23.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMCategoryUserCell.h"
#import "WMCategoryUsers.h"
#import <UIImageView+WebCache.h>
@interface WMCategoryUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *screen_name;
@property (weak, nonatomic) IBOutlet UILabel *fans_count;

@end
@implementation WMCategoryUserCell



- (void)setUser:(WMCategoryUsers *)user{
    _user = user;
    

     [self.iconImageView setingHeader:user.header];
    self.screen_name.text = user.screen_name;
    if (user.fans_count > 10000.0) {
        
        self.fans_count.text = [NSString stringWithFormat:@"%.1f万关注",user.fans_count/10000.0];
    }else{
         self.fans_count.text = [NSString stringWithFormat:@"%zd关注",user.fans_count];
    }
}

@end
