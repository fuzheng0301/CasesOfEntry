//
//  AddMoreViewController.m
//  CasesOfEntry
//
//  Created by 聚财通 on 16/2/17.
//  Copyright © 2016年 付正. All rights reserved.
//  添加新病例信息页面

#import "AddMoreViewController.h"
#import "YTKKeyValueStore.h"

@interface AddMoreViewController ()<UITextFieldDelegate>
{
    UITextField *nameTF;
    UITextField *ageTF;
    UITextField *sexTF;
    UITextField *phoneTF;
    UITextField *idTF;
    UITextField *describeTF;
    
    YTKKeyValueStore *store;
    NSMutableArray *array;
    NSMutableArray *nameArray;
}
@end

@implementation AddMoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    leftButton.hidden = NO;
    
    self.navigationItem.title = @"添加新信息";
    
    array = [[NSMutableArray alloc]init];
    nameArray = [[NSMutableArray alloc]init];
    
    [self makeUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    //延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    });
}

-(void)viewDidDisappear:(BOOL)animated
{
    nameTF.text = nil;
    ageTF.text = nil;
    sexTF.text = nil;
    idTF.text = nil;
    describeTF.text = nil;
}

#pragma mark --- 创建界面
-(void)makeUI
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 70, 30)];
    label.text = @"姓名：";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    nameTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 30, Dewidth-120, 30)];
    nameTF.layer.borderWidth = 1.0;
    nameTF.placeholder = @" (姓名*)";
    nameTF.delegate = self;
    [self.view addSubview:nameTF];
    
    UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 90, 70, 30)];
    ageLabel.text = @"年龄：";
    ageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:ageLabel];
    
    ageTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 90, Dewidth-120, 30)];
    ageTF.layer.borderWidth = 1.0;
    ageTF.placeholder = @" (年龄*)";
    ageTF.delegate = self;
    ageTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:ageTF];
    
    UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 150, 70, 30)];
    sexLabel.text = @"性别：";
    sexLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:sexLabel];
    
    sexTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 150, Dewidth-120, 30)];
    sexTF.layer.borderWidth = 1.0;
    sexTF.placeholder = @" (性别*)";
    sexTF.delegate = self;
    [self.view addSubview:sexTF];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 210, 70, 30)];
    phoneLabel.text = @"手机号：";
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneLabel];
    
    phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 210, Dewidth-120, 30)];
    phoneTF.layer.borderWidth = 1.0;
    phoneTF.placeholder = @" (手机号*)";
    phoneTF.delegate = self;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneTF];
    
    UILabel *idLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 270, 70, 30)];
    idLabel.text = @"编号：";
    idLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:idLabel];
    
    idTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 270, Dewidth-120, 30)];
    idTF.layer.borderWidth = 1.0;
    idTF.placeholder = @" (编号*)";
    idTF.delegate = self;
    idTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:idTF];
    
    UILabel *describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 330, 70, 30)];
    describeLabel.text = @"描述：";
    describeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:describeLabel];
    
    describeTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 330, Dewidth-120, 30)];
    describeTF.layer.borderWidth = 1.0;
    describeTF.placeholder = @" (描述)";
    describeTF.delegate = self;
    [self.view addSubview:describeTF];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 390, Dewidth-60, 45);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setBackgroundImage:[[UIImage imageNamed:@"nav_bg" ]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 3, 5, 3)] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark --- 点击保存按钮
-(void)didClickBtn
{
    if ([nameTF.text isEqualToString:@""] || [ageTF.text isEqualToString:@""] || [sexTF.text isEqualToString:@""] || [idTF.text isEqualToString:@""] || [phoneTF.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息填写不完整(*为必填项)" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
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
    NSDictionary *user = @{@"id": idTF.text, @"name": nameTF.text, @"age": ageTF.text, @"sex":sexTF.text, @"phone":phoneTF.text, @"describe":describeTF.text};
    [store putObject:user withId:idTF.text intoTable:tableName];
    //先取出原来的
    NSDictionary *dic = [store getObjectById:@"1" fromTable:@"user_table"];
    if (dic) {
        [array removeAllObjects];
        [nameArray removeAllObjects];
        NSMutableArray *arr = dic[@"id"];
        for (int i = 0 ; i < arr.count; i++) {
            [array addObject:arr[i]];
            [nameArray addObject:dic[@"table"][i]];
        }
    }
    
    [array addObject:idTF.text];
    [nameArray addObject:nameTF.text];
    
    NSDictionary *dict = @{@"id":array,@"table":nameArray};
    [store createTableWithName:@"user_table"];
    [store putObject:dict withId:@"1" intoTable:@"user_table"];
    
    //返回
    [self leftButtonAction:nil];
}

#pragma mark --- 开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 128 - (Deheight - 216.0);//键盘高度216
    
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

#pragma mark --- 点击屏幕空白处收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    //动画效果
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame =CGRectMake(0, 64, Dewidth, Deheight);
    }];
}

#pragma mark --- 返回按钮
-(void)leftButtonAction:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
