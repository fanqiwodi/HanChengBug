//
//  MessageViewController.m
//  Hancheng
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "DBHelper.h"
#import "LGAlertView.h"

@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    FMDatabase *db;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MessageViewController


- (void)initTableView
{
    self.myTableView.backgroundColor = [UIColor colorWithHexString:@"F1F1F6"];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView setTableFooterView:[UIView new]];
    [self.myTableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MessageTableViewCell class])];
    self.myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDic:self.arr[indexPath.row]];
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置缺省页面
    UIImageView *imgWithoutNodata = [UIImageView new];
    [self.view addSubview:imgWithoutNodata];
    imgWithoutNodata.image = [UIImage imageNamed:@"消息缺省"];
    WS(myself);
    [imgWithoutNodata mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(myself.view);
        make.centerY.mas_equalTo(myself.view).offset(-80*REM);
    }];
    UILabel *lWithoutNoData = [UILabel new];
    [self.view addSubview:lWithoutNoData];
    lWithoutNoData.textAlignment = 1;
    lWithoutNoData.text = @"您暂时还没有收到消息";
    lWithoutNoData.font = [UIFont systemFontOfSize:15];
    lWithoutNoData.textColor = [UIColor colorWithHexString:WORDCOLOR];
    [lWithoutNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imgWithoutNodata);
        make.top.equalTo(imgWithoutNodata.mas_bottom).offset(20*REM);
        
    }];
    
    [self initTableView];
    
    self.title = @"我的消息";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(clearallAction:)];
    
    [[RootInstance shareRootInstance].rootDic removeObjectForKey:@"信鸽推送条目"];
    
    
    // 设置缺省页面
    [RACObserve(self, arr)subscribeNext:^(NSArray *arr) {
       
        if (arr.count == 0) {
            
            [self.view bringSubviewToFront:imgWithoutNodata];
            [self.view bringSubviewToFront:lWithoutNoData];
            
        } else {
            [self.view sendSubviewToBack:imgWithoutNodata];
            [self.view sendSubviewToBack:lWithoutNoData];
        }
    }];
     
    
    // Do any additional setup after loading the view from its nib.
}


- (BOOL)deleteDatabse
{
    BOOL success = NO;
    NSError *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // delete the old db.
    
    if ([fileManager fileExistsAtPath:RETURNPATH(@"systemNoti.db")])
    {
       db = [DBHelper getDataBase:@"systemNoti.db"];
        if ( [db close]) {
            success = [fileManager removeItemAtPath:RETURNPATH(@"systemNoti.db") error:&error];
            [fileManager removeItemAtPath:RETURNPATH(@"PersonInfo.db") error:&error];
            if (!success) {
                NSAssert1(0, @"Failed to delete old database file with message '%@'.", [error localizedDescription]);
            }
        }
   
    }
    NSLog(@"ifReadOnly value: %@" ,success ? @"YES":@"NO");
    return success;
}

- (void)clearallAction:(UIBarButtonItem *)item
{
    LGAlertView *alt = [[LGAlertView alloc] initWithTitle:@"提示" message:@"您确定要清空消息" style:0 buttonTitles:@[@"清空"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil];
    alt.buttonsBackgroundColorHighlighted = [UIColor colorWithHexString:@"ff5000"];
    alt.buttonsTitleColor = [UIColor colorWithHexString:@"ff5000"];
    alt.cancelButtonTitleColor = [UIColor colorWithHexString:@"999999"];
    [alt showAnimated:YES completionHandler:^{
        
    }];
    alt.actionHandler = ^(LGAlertView *alertView, NSString *title, NSUInteger index){
        
        if (index==0) {
           BOOL res = [self deleteDatabse];
            if (res) {
                [self.arr removeAllObjects];
                [self.myTableView reloadData];
            }
        }
    };
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[RootInstance shareRootInstance].rootDic removeObjectForKey:@"信鸽推送我的信息"];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
