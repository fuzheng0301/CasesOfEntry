//
//  AboutMeViewController.m
//  CasesOfEntry
//
//  Created by 聚财通 on 16/3/31.
//  Copyright © 2016年 付正. All rights reserved.
//

#import "AboutMeViewController.h"
#import "HelpOrUseViewController.h"

@interface AboutMeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    HelpOrUseViewController *helpOrUseVC;
    
    UITableView *mytableView;
    
    UIImageView *backImgView;
    UIImageView *iconImgView;
    UILabel *titleLabel;
    UIView *lineView;
    
    UIButton *button;
}
@end

@implementation AboutMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于我";
    
    leftButton.hidden = NO;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    helpOrUseVC = [[HelpOrUseViewController alloc]init];
    
    //创建tableview
    [self makeTableView];
    //创建界面
    [self makeUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:43/255.0 green:100/255.0 blue:166/255.0 alpha:1.000];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:66/255.0 green:174/255.0 blue:279/255.0 alpha:1.000];
}

#pragma mark --- 创建tableview
-(void)makeTableView
{
    backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Dewidth, Deheight-64)];
    backImgView.image = [UIImage imageNamed:@"background"];
    
    mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Dewidth, Deheight-64) style:UITableViewStylePlain];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    mytableView.backgroundColor = [UIColor clearColor];
    mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mytableView setBackgroundView:backImgView];
    [self.view addSubview:mytableView];
}

#pragma mark --- 创建界面
-(void)makeUI
{
    iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake((Dewidth-100)/2, 30, 100, 100)];
    iconImgView.layer.cornerRadius = 20;
    iconImgView.image = [UIImage imageNamed:@"icon"];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((Dewidth-200)/2, CGRectGetMaxY(iconImgView.frame)+15, 200, 30)];
    titleLabel.textColor = [UIColor colorWithWhite:0.306 alpha:1.000];
    titleLabel.text = @"病例信息";
    titleLabel.textColor = [UIColor colorWithWhite:0.145 alpha:1.000];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((Dewidth-100)/2, 20, 100, 25);
    [button addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"使用协议" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 15];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }
    else{
        return 1;
    }
}

#pragma mark --- 设置行内容
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor = [UIColor colorWithWhite:0.306 alpha:1.000];
    
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor clearColor];
        [cell addSubview:iconImgView];
        [cell addSubview:titleLabel];
    }
    else if (indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            [cell addSubview:lineView];
            cell.textLabel.text = @"去评分";
        }
        else{
            lineView.frame = CGRectMake(10, 0.2, Dewidth-20, 0.4);
            [cell addSubview:lineView];
            cell.textLabel.text = @"帮助中心";
        }
    }
    else{
        cell.backgroundColor = [UIColor clearColor];
        [cell addSubview:button];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 50;
    }
    else{
        return 200;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //去评分
            NSString *urlStr;
            if (CurrentIOS7) {
                urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8", @"1092377199"];
            }
            else{
                urlStr = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"1092377199"];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
        else{
            //帮助中心
            helpOrUseVC.isHelp = YES;
            helpOrUseVC.title = @"帮助中心";
            [self.navigationController pushViewController:helpOrUseVC animated:YES];
        }
    }
}

#pragma mark --- 点击使用协议
-(void)didClickBtn
{
    helpOrUseVC.isHelp = NO;
    helpOrUseVC.title = @"使用协议";
    [self.navigationController pushViewController:helpOrUseVC animated:YES];
}

#pragma mark --- 左边返回按钮
-(void)leftButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
