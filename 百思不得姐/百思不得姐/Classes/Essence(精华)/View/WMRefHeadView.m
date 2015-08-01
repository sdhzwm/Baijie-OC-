//
//  WMRefHeadView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/24.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMRefHeadView.h"


@interface WMRefHeadView()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
@implementation WMRefHeadView

+ (instancetype)refHeadView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    self.btn.showsTouchWhenHighlighted = NO;
}
- (void)setFrame:(CGRect)frame{
 
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    
    [super setFrame:frame];
  
    
}

-(void)setState:(NSString *)state{
    _state = state;
    
    if ([state isEqualToString:@"ref"]) {
        [self.btn setTitle:@"推荐标签" forState:UIControlStateNormal];
        self.btn.enabled = YES;
    }else{
        [self.btn setTitle:@"已订阅标签--根据标签推荐你喜欢的内容" forState:UIControlStateNormal];
        self.btn.enabled = NO;

    }
}
- (IBAction)onClick:(UIButton*)sender {
   
    if ([self.delegate respondsToSelector:@selector(headView:didOnclick:)]) {
        NSLog(@"%@",@"ssssssssssssss");

        [self.delegate headView:self didOnclick:sender];
    }
}


@end
