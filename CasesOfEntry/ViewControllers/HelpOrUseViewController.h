//
//  HelpOrUseViewController.h
//  CasesOfEntry
//
//  Created by 聚财通 on 16/4/1.
//  Copyright © 2016年 付正. All rights reserved.
//  帮助中心/使用协议页面

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define Dewidth [UIScreen mainScreen].bounds.size.width
#define Deheight [UIScreen mainScreen].bounds.size.height

@interface HelpOrUseViewController : BaseViewController

@property (nonatomic, assign) BOOL isHelp;

@end
