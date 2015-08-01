//
//  WMTopicPictureView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/29.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "WMWordToip.h"
#import "WMProgressView.h"
#import "WMShowModelImageController.h"
@interface  WMTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;
@property (weak, nonatomic) IBOutlet UIButton *btnTitle;
@property (weak, nonatomic) IBOutlet WMProgressView *prigressView;

@end
@implementation WMTopicPictureView

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showModelConrller)]];
}

- (void)showModelConrller{
    WMShowModelImageController *showVC = [[WMShowModelImageController alloc]init];
    showVC.wordToip = _wordToip;
    if (self.imageView.image!=nil) {
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVC animated:YES completion:nil];
    }
}
+(instancetype)initWithTopicPictureView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}



- (void)setWordToip:(WMWordToip *)wordToip{

    _wordToip = wordToip;
    //设置图片下载及进度
    [self setPrigressNumber];
    //设置图片的的GIF及大图处理
    [self setPictureView];
}

//设置图片下载及进度
- (void)setPrigressNumber{
    [self.prigressView setProgress:_wordToip.progressNuber animated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_wordToip.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.prigressView.hidden = NO;
        _wordToip.progressNuber = 1.0 * receivedSize / expectedSize;
        [self.prigressView setProgress:_wordToip.progressNuber animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.prigressView.hidden = YES;
        
        if(!_wordToip.isLargePicture)return;
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(_wordToip.imageFrame.size, YES, 0.0);
        //将下载完的的Image绘制到图形上下文中
        CGFloat width = _wordToip.imageFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }];
}
 //设置图片的的GIF及大图处理
- (void)setPictureView{
    //判断是否是GIF图片,获取图片的后缀
    NSString *isGif = _wordToip.large_image.pathExtension;
    self.gifImage.hidden = ![isGif.uppercaseString isEqualToString:@"GIF"];
    
    if (_wordToip.isLargePicture) {
        self.btnTitle.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.btnTitle.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
