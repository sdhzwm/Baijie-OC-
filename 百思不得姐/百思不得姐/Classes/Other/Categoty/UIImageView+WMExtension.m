//
//  UIImageView+WMExtension.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/3.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "UIImageView+WMExtension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (WMExtension)

- (void)setingHeader:(NSString *)url{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] roundImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image roundImage]:placeholder;
    }];
}
@end
