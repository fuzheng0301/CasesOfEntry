//
//  BaseViewController.m
//  BaseFramework
//
//  Created by fuzheng on 15/12/15.
//  Copyright © 2015年 fuzheng. All rights reserved.
//

#import "BaseViewController.h"
#import "Util.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBarHidden = NO;
    //打开系统右划返回
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    
    [self.view setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view setBackgroundColor:[UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:66/255.0 green:174/255.0 blue:279/255.0 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    leftButton = [[UIButton alloc] init];
    [leftButton setFrame:CGRectMake(0, 0, 50, 44)];
    [leftButton setImage:[UIImage imageNamed:@"back-(.png"] forState:UIControlStateNormal];
    leftButton.contentMode = UIViewContentModeScaleAspectFit;
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0,-30, 0, 0);
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftButton setHidden:YES];
    
    rightButton = [[UIButton alloc] init];
    [rightButton setFrame:CGRectMake(0, 0, 40, 44)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    rightButton.contentMode = UIViewContentModeScaleAspectFit;
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightButton setHidden:YES];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - ButtonAction

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self bgButtonAction:nil];
}

- (void)bgButtonAction:(id)sender
{
    
}

- (void)leftButtonAction:(id)sender
{
    
}

- (void)rightButtonAction:(id)sender
{
}

#pragma mark- alertView

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message
{
    if(showAlertView)
    {
        showAlertView = nil;
    }
    showAlertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [showAlertView show];
}

//创建按钮
-(UIButton *)createButtonWithButtonType:(UIButtonType)buttonType andFrame:(CGRect)frame andSelecet:(SEL)selector andTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andBackgroundColor:(UIColor *)backgroundColor andNormalImage:(UIImage *)normalIcon andSelectedImage:(UIImage *)selectedIcon addView:(id)view
{
    UIButton *btn=[UIButton buttonWithType:buttonType];
    btn.frame=frame;
    [btn setBackgroundColor:backgroundColor];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:normalIcon forState:UIControlStateNormal];
    [btn setBackgroundImage:selectedIcon forState:UIControlStateSelected];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [view addSubview:btn];
    return btn;
}

//创建label
-(UILabel *)createLabelWithFrame:(CGRect)frame andTitle:(NSString *)title andFontSize:(CGFloat )size backGroudColor:(NSString *)colorString textAlignment:(NSTextAlignment )aligment andMaskToBounds:(BOOL)maskToBounds addView:(id)view
{
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    label.text=title;
    label.backgroundColor = [self colorWithHex:colorString];
    label.textAlignment = aligment;
    label.font=[UIFont systemFontOfSize:size];
    if (maskToBounds==YES) {
        label.layer.cornerRadius=5.0;
        label.layer.masksToBounds=YES;
    }
    [view addSubview:label];
    return label;
}

//创建textField
-(UITextField *)createTextfieldWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholder andDelegate:(id)delegate addView:(id)view
{
    UITextField *textField=[[UITextField alloc] initWithFrame:frame];
    textField.placeholder=placeholder;
    textField.delegate=delegate;
    [view addSubview:textField];
    return textField;
}

//创建textView
-(UITextView *)createTextViewWithFrame:(CGRect)frame andDelegate:(id)delegate addView:(id)view
{
    UITextView *textView=[[UITextView alloc] initWithFrame:frame];
    textView.delegate=delegate;
    [view addSubview:textView];
    return textView;
}

//创建ImageView
-(UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(UIImage *)icon addView:(id)view
{
    UIImageView *iconView=[[UIImageView alloc] initWithFrame:frame];
    iconView.image=icon;
    [view addSubview:iconView];
    return iconView;
}

//创建tableView
-(UITableView *)createTableViewWithFrame:(CGRect)frame andDataSource:(id)dataSource andDelegate:(id)delegate addView:(id)view
{
    UITableView *tableView=[[UITableView alloc] initWithFrame:frame];
    tableView.dataSource=dataSource;
    tableView.delegate=delegate;
    [view addSubview:tableView];
    return tableView;
}

//创建scrollView
-(UIScrollView *)createScrollViewWithFrame:(CGRect)frame andDelegate:(id)delegate andContentSize:(CGSize)size andShowsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator andShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator andPagingEnabled:(BOOL)pagingEnabled addView:(id)view
{
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate=delegate;
    scrollView.contentSize=size;
    scrollView.showsHorizontalScrollIndicator=showsHorizontalScrollIndicator;
    scrollView.showsVerticalScrollIndicator=showsVerticalScrollIndicator;
    scrollView.pagingEnabled=pagingEnabled;
    [view addSubview:scrollView];
    return scrollView;
}

- (UIColor *)colorWithHex:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red / 255.0f)green:(float)(green / 255.0f)blue:(float)(blue / 255.0f)alpha:1.0f];
}

@end
