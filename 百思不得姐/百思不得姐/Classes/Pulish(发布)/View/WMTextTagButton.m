
//
//  WMTextTagButton.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/8.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMTextTagButton.h"

@implementation WMTextTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];

        [self setBackgroundImage:[UIImage imageNamed:@"post_tag_disable_sub"] forState:UIControlStateNormal];

        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:WMRGBColor(130, 184, 228) forState:UIControlStateNormal];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = WMRGBColor(130, 184, 228).CGColor;
       
      
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];

    [self sizeToFit];
    self.width += 3 * WMTagMargin ;
    self.height = 25;
    self.layer.cornerRadius = self.width * 0.05;
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x  = WMTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + WMTagMargin;

}
@end
