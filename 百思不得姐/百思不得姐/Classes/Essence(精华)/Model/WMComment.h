//
//  WMComment.h
//  百思不得姐
//
//  Created by 王蒙 on 15/8/2.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WMUser;
@interface WMComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) WMUser *user;
@end
