//
//  SimpleCall_mojun_ViewController.m
//  SimpleCall_mojun
//
//  Created by mj on 16/1/26.
//  Copyright © 2016年 mj. All rights reserved.
//

#import "SimpleCall_mojun_ViewController.h"

@interface SimpleCall_mojun_ViewController ()


@property (nonatomic,strong) UIWebView *webView;


@end

@implementation SimpleCall_mojun_ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _webView=[[UIWebView alloc] init];
        
    }
    return self;
}



-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [self removeFromParentViewController];
}


+(void)call:(NSString *)number inViewController:(UIViewController *)vc failBlock:(void(^)())failBlock
{
    
    //拨打电话
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]];
    
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    
    if(!canOpen){//不能打开
        if(failBlock!=nil) failBlock(); return;
    }
    
    SimpleCall_mojun_ViewController *mediaVC=[[SimpleCall_mojun_ViewController alloc] init];
    
    [vc addChildViewController:mediaVC];
    
    mediaVC.view.frame=CGRectZero;
    mediaVC.view.alpha=.0f;
    
    [vc.view addSubview:mediaVC.view];
    
    //打电话
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [mediaVC.webView loadRequest:request];
}



-(void)dealloc
{
    self.webView=nil;
}






@end
