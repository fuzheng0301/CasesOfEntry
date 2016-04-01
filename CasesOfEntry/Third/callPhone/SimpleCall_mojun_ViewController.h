//
//  SimpleCall_mojun_ViewController.h
//  SimpleCall_mojun
//
//  Created by mj on 16/1/26.
//  Copyright © 2016年 mj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCall_mojun_ViewController : UIViewController

/**
 *  打电话
 *
 *  @param number                  电话号码
 *  @param inViewController     需要打电话的控制器
 */
+(void)call:(NSString *)number inViewController:(UIViewController *)vc failBlock:(void(^)())failBlock;


@end

/*
 *使用方法:
 *1.导入本文件到工程;
 *2.导入头文件SimpleCall_mojun_ViewController.h;
 *3.示例代码:
 *
 [SimpleCall_mojun_ViewController call:@"111111111111111" inViewController:self failBlock:^{
 NSLog(@"真机运行  模拟器不能打电话");
 }];
 *
 */
