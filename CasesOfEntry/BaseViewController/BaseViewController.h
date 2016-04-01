//
//  BaseViewController.h
//  BaseFramework
//
//  Created by fuzheng on 15/12/15.
//  Copyright © 2015年 fuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BaseViewController : UIViewController
{
    UIButton *rightButton;
    UIButton *leftButton;
    
    UIAlertView *showAlertView;
}

- (BOOL)showNetReachableAlert;
//- (void)setBackGroundClicke:(UIView *)view;
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message;

//创建按钮
-(UIButton *)createButtonWithButtonType:(UIButtonType)buttonType andFrame:(CGRect)frame andSelecet:(SEL)selector andTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)backgroundColor andNormalImage:(UIImage *)normalIcon andSelectedImage:(UIImage *)selectedIcon addView:(id)view;

//创建label
-(UILabel *)createLabelWithFrame:(CGRect)frame andTitle:(NSString *)title andFontSize:(CGFloat )size backGroudColor:(NSString *)colorString textAlignment:(NSTextAlignment )aligment andMaskToBounds:(BOOL)maskToBounds addView:(id)view;

//创建textField
-(UITextField *)createTextfieldWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andDelegate:(id)delegate addView:(id)view;

//创建textView
-(UITextView *)createTextViewWithFrame:(CGRect)frame andDelegate:(id)delegate addView:(id)view;

//创建ImageView
-(UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(UIImage *)icon addView:(id)view;

//创建tableView
-(UITableView *)createTableViewWithFrame:(CGRect)frame andDataSource:(id)dataSource andDelegate:(id)delegate addView:(id)view;

//创建scrollView
-(UIScrollView *)createScrollViewWithFrame:(CGRect)frame andDelegate:(id)delegate andContentSize:(CGSize)size andShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator andShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator andPagingEnabled:(BOOL)pagingEnabled addView:(id)view;

@end
