//
//  InfoListViewController.h
//  CasesOfEntry
//
//  Created by 聚财通 on 16/2/17.
//  Copyright © 2016年 付正. All rights reserved.
//  信息详情页面

#import <UIKit/UIKit.h>

#define Dewidth [UIScreen mainScreen].bounds.size.width
#define Deheight [UIScreen mainScreen].bounds.size.height

@interface InfoListViewController : UIViewController

@property (nonatomic, retain) NSMutableDictionary * dataDic;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * idStr;

@end
