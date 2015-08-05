//
//  WMMeCell.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/4.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMMeCell.h"

@implementation WMMeCell

 /**初始化cell*/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = image;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize: 14];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = 30;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + WMWordCellMargin;
}
@end
