//
//  WMSubscirUserTagCell.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/24.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMSubscirUserTagCell.h"
#import "WMSubscribedTag.h"
#import <UIImageView+WebCache.h>
@interface WMSubscirUserTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *image_list;
@property (weak, nonatomic) IBOutlet UILabel *sub_number;
@property (weak, nonatomic) IBOutlet UILabel *theme_name;
@end
@implementation WMSubscirUserTagCell

+(instancetype)subTagCell{
    
    WMSubscirUserTagCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    return cell;
    
}

- (void)setSubTag:(WMSubscribedTag *)subTag{
    
    
    self.theme_name.text = subTag.theme_name;
    if (subTag.sub_number > 10000.0) {
        
        self.sub_number.text = [NSString stringWithFormat:@"%.1f万推荐",subTag.sub_number/10000.0];
    }else{
        self.sub_number.text = [NSString stringWithFormat:@"%zd推荐",subTag.sub_number];
    }
    [self.image_list sd_setImageWithURL:[NSURL URLWithString:subTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
