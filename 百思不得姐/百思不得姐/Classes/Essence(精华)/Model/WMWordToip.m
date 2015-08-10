//
//  WMWordToip.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/27.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMWordToip.h"
#import "WMComment.h"
#import "WMUser.h"

@implementation WMWordToip
//成员属性
{
    CGFloat _cellHeight;
    CGRect _imageFrame;
    CGRect _voiceFrame;
    CGRect _videoFrame;
}
//需要转化的属性
+ (NSDictionary *)replacedKeyFromPropertyName{

    return @{ @"small_image":@"image0",
              @"middle_image":@"image1",
              @"large_image":@"image2",
              @"ID":@"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    //    return @{@"top_cmt" : [XMGComment class]};
    return @{@"top_cmt" : @"WMComment"};
}
//首先要判断帖子是否是今年的，如果是今年的则有以下情况
//是否是今天的:如果是今天 -1小时内的话显示XX分钟，否则是显示xx小时
//如果是昨天的话则显示昨天XX点，分
//剩下的显示XX月XX日 HH：mm:ss
//如果不是今天的话则显示yyyy-MM-dd HH:mm:ss
- (NSString *)create_time{
    //日期转化
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
   
    NSDate *currDate = [fmt dateFromString:_create_time];
    //如果是今年
    if (currDate.isYear) {
        if (currDate.isToDay) {
            //取出小时
            NSDateComponents *component = [[NSDate date] deltaFrom:currDate];
            if (component.hour>=1) {
                return [NSString stringWithFormat:@"%zd小时前",component.hour];
            }else if (component.month>=1){
                return [NSString stringWithFormat:@"%zd分钟前",component.month];
            }else{
                return [NSString stringWithFormat:@"刚刚"];
            }
        }else if (currDate.isYesterDay){
            return [fmt stringFromDate:currDate];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:currDate];
        }
       
    }else{
        return _create_time;
    }
    
}

//计算cell的高度
- (CGFloat)cellHeight{
    if (!_cellHeight) {
         //获取文字的最大尺寸
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * WMWordCellMargin, MAXFLOAT);
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        //计算只显示文字的话的cell的高度, 上面视图的Y值 + 文字内容的高度 + 两个间隔
        _cellHeight = WMTextTopViewY + textH  + 2 * WMWordCellMargin;
     
        if (self.type == EssenceTypePicture){
            if (self.width != 0 && self.height != 0) {
                CGFloat imageW = maxSize.width;
                CGFloat imageH = imageW * self.height / self.width;
                CGFloat imageX = WMWordCellMargin;
                CGFloat imageY = textH + WMWordCellMargin + WMTitilesViewY;
               
                if (imageH >= WMLargePictureMaxH) {
                    imageH = WMLargePictureH;
                    self.largePicture = YES;
                }
                _imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
                _cellHeight += imageH + WMWordCellMargin;
            }
        }
        
        if (self.type == EssenceTypeVoice){
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            CGFloat voiceX = WMWordCellMargin;
            CGFloat voiceY = textH + WMWordCellMargin + WMTitilesViewY;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + WMWordCellMargin;
            
        }
        if (self.type == EssenceTypeVideo){
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            CGFloat videoX = WMWordCellMargin;
            CGFloat videoY = textH + WMWordCellMargin + WMTitilesViewY;
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + WMWordCellMargin;
            
        }
        
        WMComment *cmt = [self.top_cmt firstObject];
        if (cmt) {
             NSString *content = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
             CGFloat hotTitleH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
             _cellHeight +=  hotTitleH + WMWordCellMargin + 10;
        }
        _cellHeight += WMWordCellMargin + WMTextBottomViewH;
    }
    return _cellHeight;
}

@end
