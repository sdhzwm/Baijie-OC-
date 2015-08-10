//
//  WMConst.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/27.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EssenceTypeAll = 1,
    EssenceTypePicture = 10,
    EssenceTypeWord = 29,
    EssenceTypeVoice = 31,
    EssenceTypeVideo = 41
    
}EssenceType;

UIKIT_EXTERN CGFloat const WMTitilesViewH;
UIKIT_EXTERN CGFloat const WMTitilesViewY;
/**间隔*/
UIKIT_EXTERN CGFloat const WMWordCellMargin;
/**上方文本标签的Y*/
UIKIT_EXTERN CGFloat const WMTextTopViewY;
/**下面的标签栏*/
UIKIT_EXTERN CGFloat const WMTextBottomViewH;
/**大图片的高度-设定值，一定等于或大于就为大图*/
UIKIT_EXTERN CGFloat const WMLargePictureMaxH;
/**图片要显示的高度*/
UIKIT_EXTERN CGFloat const WMLargePictureH;
UIKIT_EXTERN NSString * const WMUserSexMale;
UIKIT_EXTERN NSString * const WMUserSexFemale;
UIKIT_EXTERN CGFloat const WMTagMargin;
/**用于发送tabbar选中的通知*/
UIKIT_EXTERN NSString *const WMTabBarDidSelectNotification;