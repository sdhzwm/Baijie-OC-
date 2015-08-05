//
//  WMMeButton.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/4.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMMeButton.h"
#import "WMSquare.h"
#import <UIButton+WebCache.h>
@implementation WMMeButton

- (void)settingBtn{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}


- (void)awakeFromNib{
    [self settingBtn];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self settingBtn];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //调整图片
    self.imageView.y = self.height *0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    //调整label
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

- (void)setHighlighted:(BOOL)highlighted{}

- (void)setSquare:(WMSquare *)square{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
  
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}
@end
