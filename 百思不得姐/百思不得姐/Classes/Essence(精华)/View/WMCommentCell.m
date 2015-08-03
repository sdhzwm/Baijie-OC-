//
//  WMCommentCell.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/3.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMCommentCell.h"
#import <UIImageView+WebCache.h>
#import "WMComment.h"
#import "WMUser.h"

@interface WMCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation WMCommentCell

- (BOOL)canBecomeFirstResponder{
    return  YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}
- (void)awakeFromNib{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setCmt:(WMComment *)cmt{
    _cmt = cmt;
    
    [self.profileImageView setingHeader:cmt.user.profile_image];
    self.sexView.image = [cmt.user.sex isEqualToString:WMUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.usernameLabel.text = cmt.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",cmt.like_count];
    self.contentLabel.text = cmt.content;
    
    if (cmt.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",self.cmt.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
    
}


@end
