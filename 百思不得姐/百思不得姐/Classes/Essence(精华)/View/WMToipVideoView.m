//
//  WMToipVoiceView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/31.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMToipVideoView.h"
#import "WMProgressView.h"
#import "WMWordToip.h"
#import "WMShowModelImageController.h"
#import <UIImageView+WebCache.h>
@interface WMToipVideoView()
/**点击的数量*/
@property (weak, nonatomic) IBOutlet UILabel *tapNumber;
/**声音时长*/
@property (weak, nonatomic) IBOutlet UILabel *timeCount;
/**进度图片*/
@property (weak, nonatomic) IBOutlet WMProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end
@implementation WMToipVideoView


+ (instancetype)initWithToipVoicView{

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    self.playBtn.hidden = YES;
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
}

- (void)setWordToip:(WMWordToip *)wordToip{
    
    _wordToip = wordToip;
    NSUInteger seconed = wordToip.voicetime / 60;
    NSUInteger minute = seconed % 60;
    
    [self.progressView setProgress:wordToip.progressNuber animated:NO];
    self.timeCount.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,seconed];
    
    self.tapNumber.text = [NSString stringWithFormat:@"%zd点击",wordToip.playcount];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:wordToip.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        self.playBtn.hidden = YES;
        wordToip.progressNuber = 1.0 * receivedSize/expectedSize;
        [self.progressView setProgress:_wordToip.progressNuber animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image!=nil) {
            self.playBtn.hidden = NO;
            self.progressView.hidden = YES;
            
            self.imageView.image = image;
        }
    }];
}
- (IBAction)playBtn:(id)sender {
    
}

@end
