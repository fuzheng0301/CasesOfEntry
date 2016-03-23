//
//  InfoViewController.m
//  CasesOfEntry
//
//  Created by 聚财通 on 16/2/17.
//  Copyright © 2016年 付正. All rights reserved.
//

#import "InfoViewController.h"
#import "AddMoreViewController.h"
#import "YTKKeyValueStore.h"
#import "InfoListViewController.h"

@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTableV;
    NSMutableArray *informationArr;
    NSMutableArray *infoArray;
    UILabel *label;
    
    AddMoreViewController *vc;
    YTKKeyValueStore *store;
    
    NSInteger recordSection;//记录区
    
    NSMutableArray *idArrayData;
    NSMutableArray *nameArrayData;
    UISearchDisplayController *searchDisplayController;
}
@end

@implementation InfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(didClickAddInformation)];
    
    self.navigationItem.title = @"信息列表";
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.916 alpha:1.000];
    
    informationArr = [[NSMutableArray alloc]init];
    infoArray = [[NSMutableArray alloc]init];
    
    //创建tableView
    [self createTableView];
    
    vc = [[AddMoreViewController alloc]init];
    
    //创建搜索框
    [self createSearchBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    store = [[YTKKeyValueStore alloc] initDBWithName:@"test.db"];
    NSDictionary *dic = [store getObjectById:@"1" fromTable:@"user_table"];
    
    if (dic) {
        [informationArr removeAllObjects];
        NSMutableArray *idArray = dic[@"id"];
        for (int i = 0; i < idArray.count; i++) {
            NSDictionary *queryUser = [store getObjectById:idArray[i] fromTable:dic[@"table"][i]];
            [informationArr addObject:queryUser];
        }
    }
    
    [myTableV reloadData];
}

#pragma mark --- 创建tableview
-(void)createTableView
{
    myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Dewidth, Deheight) style:UITableViewStylePlain];
    myTableV.delegate = self;
    myTableV.dataSource = self;
    myTableV.backgroundColor = [UIColor clearColor];
    myTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableV];
}

#pragma mark --- 创建搜索框
-(void)createSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    searchBar.placeholder = @"搜索";
    // 添加 searchbar 到 headerview
    myTableV.tableHeaderView = searchBar;
    
    // 用 searchbar 初始化 SearchDisplayController
    // 并把 searchDisplayController 和当前 controller 关联起来
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithWhite:0.837 alpha:1.000];
    // searchResultsDataSource 就是 UITableViewDataSource
    searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    searchDisplayController.searchResultsDelegate = self;
}

#pragma mark --- 判断是否有数据
-(void)isDonotHaveInformations
{
    if (informationArr.count == 0) {
        [label removeFromSuperview];
        label = [[UILabel alloc]initWithFrame:CGRectMake(50, 80, Dewidth-100, 30)];
        label.text = @"暂无数据";
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [myTableV addSubview:label];
    }else{
        [label removeFromSuperview];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //判断是否有数据
    [self isDonotHaveInformations];
    
    if (tableView == myTableV) {
        return informationArr.count;
    }else{
        // 谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchDisplayController.searchBar.text];
        //数字正则表达式
        NSString *biaod = @"^[0-9]{0,11}$";
        NSPredicate *number = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",biaod];
        if ([number evaluateWithObject:searchDisplayController.searchBar.text]) {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for (int i = 0; i < informationArr.count; i++) {
                [arr addObject:informationArr[i][@"id"]];
            }
            idArrayData =  [[NSMutableArray alloc] initWithArray:[arr filteredArrayUsingPredicate:predicate]];
            [nameArrayData removeAllObjects];
            return idArrayData.count;
        }else{
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for (int i = 0; i < informationArr.count; i++) {
                [arr addObject:informationArr[i][@"name"]];
            }
            nameArrayData =  [[NSMutableArray alloc] initWithArray:[arr filteredArrayUsingPredicate:predicate]];
            [idArrayData removeAllObjects];
            return nameArrayData.count;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark --- 设置行内容
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (tableView == myTableV) {
        if (informationArr.count != 0) {
            cell.textLabel.text = informationArr[indexPath.section][@"name"];
            cell.detailTextLabel.text = informationArr[indexPath.section][@"id"];
        }
    }else{
        [infoArray removeAllObjects];
        if (idArrayData.count != 0 && nameArrayData.count == 0) {
            for (int i = 0; i < idArrayData.count; i++) {
                for (int j = 0; j < informationArr.count; j++) {
                    if ([idArrayData[i] isEqualToString:informationArr[j][@"id"]]) {
                        [infoArray addObject:informationArr[j]];
                    }
                }
            }
            cell.textLabel.text = infoArray[indexPath.section][@"name"];
            cell.detailTextLabel.text = infoArray[indexPath.section][@"id"];
        }else if (idArrayData.count == 0 && nameArrayData.count != 0) {
            for (int i = 0; i < nameArrayData.count; i++) {
                for (int j = 0; j < informationArr.count; j++) {
                    if ([nameArrayData[i] isEqualToString:informationArr[j][@"name"]]) {
                        [infoArray addObject:informationArr[j]];
                    }
                }
            }
            cell.textLabel.text = infoArray[indexPath.section][@"name"];
            cell.detailTextLabel.text = infoArray[indexPath.section][@"id"];
        }
    }
    
    return cell;
}

#pragma mark------tableView编辑(删除)
//(先操作数据源(M层),再修改UI(V层))
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //记录区和行
    recordSection = indexPath.section;
    
    [alert show];
    
}

#pragma mark --- 弹窗按钮点击区分
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSLog(@"点击了确定");
        //①.删除后台数据
        
        //②.删除本地数据
        NSDictionary *dic = [store getObjectById:@"1" fromTable:@"user_table"];
        if (dic) {
            
            if (searchDisplayController.searchBar.text.length != 0) {
                
                /*删除UI*/
                //删除总数据
                NSMutableDictionary *strDic = [[NSMutableDictionary alloc]init];
                strDic = [infoArray objectAtIndex:recordSection];
                for (int i = 0; i < informationArr.count; i++) {
                    if ([informationArr[i][@"id"] isEqualToString:strDic[@"id"]]) {
                        //删除本地数据
                        NSMutableArray *idArray = [NSMutableArray arrayWithArray:dic[@"id"]];
                        NSMutableArray *nameArray = [NSMutableArray arrayWithArray:dic[@"table"]];
                        [idArray removeObjectAtIndex:i];
                        [nameArray removeObjectAtIndex:i];
                        
                        NSDictionary *dict = @{@"id":idArray,@"table":nameArray};
                        [store createTableWithName:@"user_table"];
                        [store putObject:dict withId:@"1" intoTable:@"user_table"];
                        
                        [store deleteObjectById:dic[@"id"][i] fromTable:dic[@"table"][i]];
                        [informationArr removeObjectAtIndex:i];
                    }
                }
                //删除搜索数据
                [infoArray removeObjectAtIndex:recordSection];
                if (idArrayData.count != 0) {
                    [idArrayData removeObjectAtIndex:recordSection];
                }
                if (nameArrayData.count != 0) {
                    [nameArrayData removeObjectAtIndex:recordSection];
                }
                [searchDisplayController.searchResultsTableView reloadData];
            }else{
                //删除本地数据
                NSMutableArray *idArray = [NSMutableArray arrayWithArray:dic[@"id"]];
                NSMutableArray *nameArray = [NSMutableArray arrayWithArray:dic[@"table"]];
                [idArray removeObjectAtIndex:recordSection];
                [nameArray removeObjectAtIndex:recordSection];
                
                NSDictionary *dict = @{@"id":idArray,@"table":nameArray};
                [store createTableWithName:@"user_table"];
                [store putObject:dict withId:@"1" intoTable:@"user_table"];
                
                [store deleteObjectById:dic[@"id"][recordSection] fromTable:dic[@"table"][recordSection]];
                
                //删除UI
                [informationArr removeObjectAtIndex:recordSection];
            }
        }
        //刷新数据
        [myTableV reloadData];
    }
}

#pragma mark --- 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark --- 设置表头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark --- 设置表尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == informationArr.count-1) {
        return 10;
    }
    return 0.1;
}

#pragma mark --- 行点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoListViewController *infoListVC = [[InfoListViewController alloc]init];
    if (searchDisplayController.searchBar.text.length != 0) {
        infoListVC.dataDic = infoArray[indexPath.section];
        infoListVC.name = infoArray[indexPath.section][@"name"];
        infoListVC.idStr = infoArray[indexPath.section][@"id"];
    }else{
        infoListVC.dataDic = informationArr[indexPath.section];
        infoListVC.name = informationArr[indexPath.section][@"name"];
        infoListVC.idStr = informationArr[indexPath.section][@"id"];
    }
    
    [self.navigationController pushViewController:infoListVC animated:YES];
}

#pragma mark --- 右边添加按钮
-(void)didClickAddInformation
{
    [self.navigationController pushViewController:vc animated:YES];
}

@end
