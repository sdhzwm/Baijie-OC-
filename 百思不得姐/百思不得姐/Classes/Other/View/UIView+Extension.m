//
//  UIView+Extension.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(void) setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    frame.origin.x= x;
    self.frame = frame;
}

-(void) setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y= y;
    self.frame = frame;
}

-(void) setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    frame.size.width= width;
    self.frame = frame;
}


-(void) setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    frame.size.height= height;
    self.frame = frame;
}

-(void) setSize:(CGSize)size{
    
    CGRect frame = self.frame;
    frame.size= size;
    self.frame = frame;
}
-(void)setOrigin:(CGPoint)origin{
    
    CGRect frmae = self.frame;
    frmae.origin = origin;
    self.frame = frmae;
}
-(void) setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x= centerX;
    self.center = center;
}
-(void) setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)x{
    
    return self.frame.origin.x;
}

-(CGFloat)y{
    
    return self.frame.origin.y;
}
-(CGFloat)width{
    
    return self.frame.size.width;
}
-(CGFloat)height{
    
    return self.frame.size.height;
}


-(CGFloat)centerX {
    
    return self.center.x;
}
-(CGFloat)centerY{
    
    return self.center.y;
}
-(CGSize)size{
    return self.frame.size;
}

-(CGPoint)origin{
    return self.frame.origin;
}

- (BOOL)isShowingOnKeyWindow{
    //获取当前的主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //以主窗口0，0为坐标，计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect windowBoduns = keyWindow.bounds;
    //根据转换的坐标系来看看是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, windowBoduns);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
  
}


@end
