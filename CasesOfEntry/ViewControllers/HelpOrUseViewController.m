//
//  HelpOrUseViewController.m
//  CasesOfEntry
//
//  Created by 聚财通 on 16/4/1.
//  Copyright © 2016年 付正. All rights reserved.
//

#import "HelpOrUseViewController.h"

@interface HelpOrUseViewController ()
{
    UITextView *textView;
    
    NSString *helpStr;
    NSString *useStr;
}
@end

@implementation HelpOrUseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    leftButton.hidden = NO;
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, Dewidth-20, Deheight-84)];
    [textView setFont:[UIFont systemFontOfSize:16.0]];
    textView.userInteractionEnabled = NO;
    textView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [self.view addSubview:textView];
    
    helpStr = @"APP功能： \n        1.添加新的病例信息，其中包括必填项：姓名、年龄、性别、手机号、病例编号 和 选填项：病例描述；\n        2.对已添加的病例信息查看详情，详情页面可以点击右上角编辑按钮进行重新编辑，编辑后点击右上角完成按钮重新保存；\n        3.列表页面有搜索功能：搜索可以根据姓名和编号进行模糊搜索，搜索想要查找的病例信息搜索结果可以直接查看详情；\n        4.列表页面和搜索结果页面都可以对信息左划进行删除。";
    useStr = @"使用协议：\n        1.本软件的著作权、商标权、专利权、商业秘密等知识产权，以及与本软件相关的所有信息内容（包括但不限于文字、图片、音频、视频、图表、界面设计、版面框架、有关数据或电子文档等）均受中华人民共和国法律法规和相应的国际条约保护，作者依法享有上述相关知识产权，但相关权利人依照法律规定应享有的权利除外。未经作者书面同意，您不得为任何商业或非商业目的自行或许可任何第三方实施、利用、转让上述知识产权。\n        2.本APP给予您一项个人的、不可转让及非排他性的许可，以使用本软件。您可以为非商业目的在单一台终端设备上下载、安装、使用本软件。您可以制作本软件的一个副本，仅用作备份。备份副本必须包含原软件中含有的所有著作权信息。本条及本协议其他条款未明示授权的其他一切权利仍由作者保留，您在行使这些权利时须另外取得作者的书面许可。作者如果未行使前述任何权利，并不构成对该权利的放弃。\n        3.您充分了解并同意，您必须为自己使用过程中的一切行为负责，包括您所发表的任何内容以及由此产生的任何后果。您应对使用本服务时接触到的内容自行加以判断，并承担因使用内容而引起的所有风险，包括因对内容的正确性、完整性或实用性的依赖而产生的风险。作者无法且不会对您因前述风险而导致的任何损失或损害承担责任。";
}

-(void)viewWillAppear:(BOOL)animated
{
    if (_isHelp == YES) {
        self.title = @"帮助中心";
        textView.text = helpStr;
    }
    else{
        self.title = @"使用协议";
        textView.text = useStr;
    }
}

-(void)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
