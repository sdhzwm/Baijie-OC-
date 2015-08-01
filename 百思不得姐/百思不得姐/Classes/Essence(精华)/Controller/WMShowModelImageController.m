//
//  WMShowModelImageController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/30.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMShowModelImageController.h"
#import "WMWordToip.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface WMShowModelImageController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**大图的ImageView*/
@property (nonatomic,weak) UIImageView *imageView;
/**是否放大*/
@property (nonatomic,assign) BOOL isTap;
@end

@implementation WMShowModelImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.maximumZoomScale = 1.5;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.delegate = self;
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //设置图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 2;
    [imageView addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeWindow)];
    [tap1 requireGestureRecognizerToFail:tap];
    [imageView addGestureRecognizer:tap1];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //图片的尺寸
    CGFloat imageW = screenW;
    CGFloat imageH = imageW * self.wordToip.height / self.wordToip.width;
    if(imageH>screenH){
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH);
    }else{
        imageView.size = CGSizeMake(imageW, imageH);
        imageView.centerY = screenH * 0.5;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.wordToip.large_image]];
}

- (void)tap:(UITapGestureRecognizer*)tap{
    
        self.isTap = !self.isTap;
        if (self.isTap) {
            [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.zoomScale = 1.5;
            [self viewForZoomingInScrollView:self.scrollView];
            
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.scrollView.zoomScale = 1;
                [self viewForZoomingInScrollView:self.scrollView];
                
            }];

        }
    
      
}

- (IBAction)closeWindow {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)saveImage:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    CGFloat imageW = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageH = imageW * self.imageView.height / self.imageView.width;
    self.imageView.centerY = [UIScreen mainScreen].bounds.size.height*0.5;

    return  self.imageView;
}


@end
