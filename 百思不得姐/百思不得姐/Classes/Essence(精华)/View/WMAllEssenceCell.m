//
//  WMAllEssenceCell.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/27.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMAllEssenceCell.h"
#import "WMWordToip.h"
#import <UIImageView+WebCache.h>
#import "WMTopicPictureView.h"
#import "WMToipVoiceView.h"
#import "WMToipVideoView.h"
#import "WMComment.h"
#import "WMUser.h"
@interface WMAllEssenceCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 是否是新浪VIP*/
@property (weak, nonatomic) IBOutlet UIImageView *sina_v;
/**文本内容*/
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
/**图片视图*/
@property (nonatomic,weak) WMTopicPictureView *topicPicture;
/**声音视图*/
@property (nonatomic,weak) WMToipVoiceView *voiceView;
/**视频视图2*/
@property (nonatomic,weak) WMToipVideoView *videoView;
@property (weak, nonatomic) IBOutlet UIView *hotView;
@property (weak, nonatomic) IBOutlet UILabel *hotTitlelabel;

@end
@implementation WMAllEssenceCell

- (WMTopicPictureView *)topicPicture{
    if (!_topicPicture) {
         WMTopicPictureView *topicPicture = [WMTopicPictureView initWithTopicPictureView];
        [self.contentView addSubview:topicPicture];
        _topicPicture = topicPicture;
    }
    return _topicPicture;
}

- (WMToipVoiceView *)voiceView{
    if (!_voiceView) {
        WMToipVoiceView *voice = [WMToipVoiceView initWithToipVoicView];
        [self.contentView addSubview:voice];
        _voiceView = voice;
    }
    return _voiceView;
}

- (WMToipVideoView *)videoView{
    if (!_videoView) {
        WMToipVideoView *video = [WMToipVideoView initWithToipVoicView];
        [self.contentView addSubview:video];
        _videoView = video;
    }
    return _videoView;

}
- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

+ (instancetype)initWithCell{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)setWordToip:(WMWordToip *)wordToip{
    _wordToip = wordToip;

    [self.profileImageView setingHeader:wordToip.profile_image];
    self.nameLabel.text = wordToip.name;
    self.sina_v.hidden = !wordToip.isSina_v;
    self.createTimeLabel.text = wordToip.create_time;
    
    self.text_Label.text = wordToip.text;
    if (wordToip.type == EssenceTypePicture) {
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.topicPicture.hidden = NO;
        self.topicPicture.wordToip = wordToip;
        self.topicPicture.frame = wordToip.imageFrame;
    }else if (wordToip.type == EssenceTypeVoice){
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.topicPicture.hidden = YES;
        self.voiceView.wordToip = wordToip;
        self.voiceView.frame = wordToip.voiceFrame;
    }else if(wordToip.type == EssenceTypeVideo){
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.topicPicture.hidden = YES;
        self.videoView.wordToip  = wordToip;
        self.videoView.frame = wordToip.videoFrame;
    }else{
        self.videoView.hidden = YES;
        self.topicPicture.hidden = YES;
        self.voiceView.hidden = YES;
    }
    [self setBtnByWordToip:wordToip];
    
    WMComment *comment = [wordToip.top_cmt firstObject];
    if (comment) {
        //comment不为空
        self.hotView.hidden = NO;
        self.hotTitlelabel.text = [NSString stringWithFormat:@"%@ :%@",comment.user.username,comment.content];
    }else{
        self.hotView.hidden = YES;
    }
    
}


- (void)setBtnByWordToip:(WMWordToip*)wordToip{
    [self setTitleButton:self.dingButton count:wordToip.ding placeholder:@"顶"];
    [self setTitleButton:self.caiButton count:wordToip.cai placeholder:@"踩"];
    [self setTitleButton:self.shareButton count:wordToip.repost placeholder:@"分享"];
    [self setTitleButton:self.commentButton count:wordToip.comment placeholder:@"评论"];
}
- (void)setTitleButton:(UIButton *)btn count:(NSUInteger)count placeholder:(NSString *)placeholder{
    if(count>10000){
        placeholder = [NSString stringWithFormat:@"%.1f万", count/10000.0];
    }else if (count >0){
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }   
    [btn setTitle:placeholder forState:UIControlStateNormal];
}


- (IBAction)btnClick:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
}


- (void)setFrame:(CGRect)frame{
    
    CGFloat more = 10;
    
    frame.origin.x = more;
    frame.size.width -= 2*more;
    frame.origin.y += more;
    frame.size.height = self.wordToip.cellHeight - more;
    [super setFrame:frame];
}

@end
