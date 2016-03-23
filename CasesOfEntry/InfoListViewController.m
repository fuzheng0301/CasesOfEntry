//
//  InfoListViewController.m
//  CasesOfEntry
//
//  Created by 聚财通 on 16/2/17.
//  Copyright © 2016年 付正. All rights reserved.
//

#import "InfoListViewController.h"
#import "YTKKeyValueStore.h"

@interface InfoListViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
    UIImageView * bgImg;
    
    UITextField *nameTF;
    UITextField *ageTF;
    UITextField *sexTF;
    UITextField *idTF;
    UITextView *describeTF;
    
    BOOL isEditing;//判断是否是处于编辑状态
    
    YTKKeyValueStore *store;
    NSMutableArray *array;
    NSMutableArray *nameArray;
}
@end

@implementation InfoListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(didClickEdit)];
    
    self.navigationItem.title = @"信息详情";
    
    isEditing = NO;
    
    [self makeUI];
    
    array = [[NSMutableArray alloc]init];
    nameArray = [[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.view endEditing:YES];
}

#pragma mark --- 创建界面
-(void)makeUI
{
    // 小票背景
    bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, Dewidth - 40, 350)];
    bgImg.image = [UIImage imageNamed:@"reqMoneybg"];
    bgImg.userInteractionEnabled=YES;
    [self.view addSubview:bgImg];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 70, 30)];
    label.text = @"姓名：";
    label.textAlignment = NSTextAlignmentCenter;
    [bgImg addSubview:label];
    
    nameTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 30, Dewidth-160, 30)];
    nameTF.text = self.dataDic[@"name"];
    nameTF.enabled = false;
    nameTF.delegate = self;
    [bgImg addSubview:nameTF];
    
    UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 90, 70, 30)];
    ageLabel.text = @"年龄：";
    ageLabel.textAlignment = NSTextAlignmentCenter;
    [bgImg addSubview:ageLabel];
    
    ageTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 90, Dewidth-160, 30)];
    ageTF.text = self.dataDic[@"age"];
    ageTF.enabled = false;
    ageTF.delegate = self;
    ageTF.keyboardType = UIKeyboardTypeNumberPad;
    [bgImg addSubview:ageTF];
    
    UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 150, 70, 30)];
    sexLabel.text = @"性别：";
    sexLabel.textAlignment = NSTextAlignmentCenter;
    [bgImg addSubview:sexLabel];
    
    sexTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 150, Dewidth-160, 30)];
    sexTF.text = self.dataDic[@"sex"];
    sexTF.enabled = false;
    sexTF.delegate = self;
    [bgImg addSubview:sexTF];
    
    UILabel *idLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 210, 70, 30)];
    idLabel.text = @"编号：";
    idLabel.textAlignment = NSTextAlignmentCenter;
    [bgImg addSubview:idLabel];
    
    idTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 210, Dewidth-160, 30)];
    idTF.text = self.dataDic[@"id"];
    idTF.enabled = false;
    idTF.delegate = self;
    idTF.keyboardType = UIKeyboardTypeNumberPad;
    [bgImg addSubview:idTF];
    
    UILabel *describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 270, 70, 30)];
    describeLabel.text = @"描述：";
    describeLabel.textAlignment = NSTextAlignmentCenter;
    [bgImg addSubview:describeLabel];
    
    describeTF = [[UITextView alloc]initWithFrame:CGRectMake(95, 270, Dewidth-160, 36.5)];
    describeTF.text = self.dataDic[@"describe"];
    describeTF.editable = false;
    describeTF.delegate = self;
    //计算文本高度
    CGSize size = [describeTF sizeThatFits:CGSizeMake(CGRectGetWidth(describeTF.frame), MAXFLOAT)];
    if (size.height+33 <= 100 && size.height+33 >63) {
        describeTF.frame = CGRectMake(95, 270, Dewidth-160, size.height+33);
        bgImg.frame = CGRectMake(20, 0, Dewidth-40, 320+size.height+33);
    }else if (size.height+33 > 100) {
        describeTF.frame = CGRectMake(95, 270, Dewidth-160, 100);
        bgImg.frame = CGRectMake(20, 0, Dewidth-40, 420);
    }
    [describeTF setFont:[UIFont systemFontOfSize:17.0]];
    [bgImg addSubview:describeTF];
}

#pragma mark --- 开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 64 - (Deheight - 216.0);//键盘高度216
    
    //动画效果
    [UIView animateWithDuration:0.3 animations:^{
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
            self.view.frame = CGRectMake(0.0f, -offset, Dewidth, Deheight);
    }];
}

#pragma mark --- 当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark --- 开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 64 + frame.size.height - (Deheight - 216.0 - 64);//键盘高度216
    
    //动画效果
    [UIView animateWithDuration:0.3 animations:^{
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
            self.view.frame = CGRectMake(0.0f, -offset, Dewidth, Deheight);
    }];
}

#pragma mark --- textView代理方法
- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
    if (size.height <= 100) {
        CGRect frame = textView.frame;
        frame.size.height = size.height;
        textView.frame = frame;
        
        //键盘随之变化
        int offset = frame.origin.y + 64 + frame.size.height - (Deheight - 216.0 - 64);//键盘高度216
        
        //动画效果
        [UIView animateWithDuration:0.3 animations:^{
            
            bgImg.frame = CGRectMake(20, 0, Dewidth-40, 320+size.height);
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0)
                self.view.frame = CGRectMake(0.0f, -offset, Dewidth, Deheight);
        }];
    }
}

#pragma mark --- 点击屏幕空白处收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    //动画效果
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame =CGRectMake(0, 64, Dewidth, Deheight);
    }];
}

#pragma mark --- 右边编辑按钮
-(void)didClickEdit
{
    //动画效果
    [UIView animateWithDuration:0.3 animations:^{
        //收键盘，变坐标
        [self.view endEditing:YES];
        self.view.frame =CGRectMake(0, 64, Dewidth, Deheight);
    }];
    
    if (!isEditing) {
        nameTF.enabled = true;
        nameTF.layer.borderWidth = 1.0;
        ageTF.enabled = true;
        ageTF.layer.borderWidth = 1.0;
        sexTF.enabled = true;
        sexTF.layer.borderWidth = 1.0;
        idTF.enabled = true;
        idTF.layer.borderWidth = 1.0;
        describeTF.editable = true;
        describeTF.layer.borderWidth = 1.0;
        isEditing = YES;
        self.navigationItem.rightBarButtonItem.title = @"完成";
    }else{
        nameTF.enabled = false;
        nameTF.layer.borderWidth = 0;
        ageTF.enabled = false;
        ageTF.layer.borderWidth = 0;
        sexTF.enabled = false;
        sexTF.layer.borderWidth = 0;
        idTF.enabled = false;
        idTF.layer.borderWidth = 0;
        describeTF.editable = false;
        describeTF.layer.borderWidth = 0;
        isEditing = NO;
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        
        //保存数据
        [self saveData];
    }
}

#pragma mark --- 保存数据
-(void)saveData
{
    // Demo
    NSString *tableName = nameTF.text;
    store = [[YTKKeyValueStore alloc] initDBWithName:@"test.db"];
    [store createTableWithName:tableName];
    //删除对应数据
    [store deleteObjectById:self.idStr fromTable:self.name];
    
    NSDictionary *user = @{@"id": idTF.text, @"name": nameTF.text, @"age": ageTF.text, @"sex":sexTF.text, @"describe":describeTF.text};
    [store putObject:user withId:idTF.text intoTable:tableName];
    //先取出原来的
    NSDictionary *dic = [store getObjectById:@"1" fromTable:@"user_table"];
    if (dic) {
        [array removeAllObjects];
        [nameArray removeAllObjects];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[@"id"]];;
        NSMutableArray *nameArr = [NSMutableArray arrayWithArray:dic[@"table"]];
        for (int i = 0 ; i < arr.count; i++) {
            if ([arr[i] isEqualToString:self.idStr]) {
                [arr replaceObjectAtIndex:i withObject:idTF.text];
                [nameArr replaceObjectAtIndex:i withObject:nameTF.text];
            }
        }
        for (int i = 0; i < arr.count; i++) {
            [array addObject:arr[i]];
            [nameArray addObject:nameArr[i]];
        }
    }
    
    NSDictionary *dict = @{@"id":array,@"table":nameArray};
    [store createTableWithName:@"user_table"];
    [store putObject:dict withId:@"1" intoTable:@"user_table"];
    
}

@end
