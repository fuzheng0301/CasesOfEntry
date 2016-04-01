//
//  LaunchViewController.m
//
//
//  Created by 付正 on 16/2/19.
//  Copyright © 2016年 fuzheng. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()
{
    UIImageView *_FirstImageV;
    UIImageView *_SecondImageV;
}
@end

@implementation LaunchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatImageV];
    [self Animation];
}

- (void)creatImageV
{
    _SecondImageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _SecondImageV.contentMode = UIViewContentModeScaleAspectFill;
    _SecondImageV.image = [UIImage imageNamed:@"start"];
    [self.view addSubview:_SecondImageV];
    
    _FirstImageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _FirstImageV.contentMode = UIViewContentModeScaleAspectFill;
    _FirstImageV.image = [UIImage imageNamed:@"123"];
    [self.view addSubview:_FirstImageV];
}

- (void)Animation
{
    [UIView animateWithDuration:1.5 animations:^{
        _FirstImageV.alpha = 0.f;
        _SecondImageV.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [_FirstImageV removeFromSuperview];
         [UIView animateWithDuration:1.0 animations:^{
             _SecondImageV.alpha = 0.f;
         } completion:^(BOOL finished) {
             [_SecondImageV removeFromSuperview];
             [self.view removeFromSuperview];
         }];
    }];
}

@end
