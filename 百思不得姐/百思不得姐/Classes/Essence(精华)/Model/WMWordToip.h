//
//  WMWordToip.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/27.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMWordToip : NSObject
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/**新浪微博*/
@property (nonatomic,assign,getter = isSina_v) BOOL sina_v;
/**帖子的类型*/
@property (nonatomic,assign)EssenceType  type;


/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/**图片的宽度*/
@property (nonatomic,assign) CGFloat width;
/**图片的高度*/
@property (nonatomic,assign) CGFloat height;
/**是否是大图*/
@property (nonatomic,assign,getter=isLargePicture) BOOL largePicture;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;


/**cell的高度*/
@property (nonatomic,assign,readonly) CGFloat cellHeight;
/**图片的frame*/
@property (nonatomic,assign,readonly) CGRect imageFrame;
/**声音的frame*/
@property (nonatomic,assign,readonly) CGRect voiceFrame;
/**视频的frame*/
@property (nonatomic,assign,readonly) CGRect videoFrame;
/**下载图片的进度值*/
@property (nonatomic,assign) CGFloat progressNuber;
@end
