//
//  RemindofDealViewController.m
//  Hancheng
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RemindofDealViewController.h"
#import "RemindTableViewCell.h"
#import "OrderDetailsViewController.h"
#import "C_68Model+NetAction.h"
@interface RemindofDealViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSArray *dataArr;
@end

@implementation RemindofDealViewController

- (void)initTableView
{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"RemindTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RemindTableViewCell class])];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView setTableFooterView:[UIView new]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RemindTableViewCell class]) forIndexPath:indexPath];
    C_68Model *model = self.dataArr[indexPath.row];
    cell.titleName.text = model.proStatusName;
    cell.contentL.text = [NSString stringWithFormat:@"订单 %@\n您定的[%@]%@",model.order_sn, model.goodsName, model.proStatusName];
    cell.timeL.text = model.modify_datetime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailsViewController *orderVC = [[OrderDetailsViewController alloc]init];
    C_68Model *model = self.dataArr[indexPath.row];
    orderVC.orderId = model.orderId;
    orderVC.type = model.type;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)getNetData
{
    [C_68Model handleWithSuccessBlock:^(id returnValue) {
        self.dataArr = returnValue;
        
        [self.myTableView reloadData];
    } WithFailureBlock:^(id error) {
        NSLog(@"错误%@", error);
    } WithUid:@{@"Uid":[UserMangerDefaults UidGet]}];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];
    [self initTableView];
    [self getNetData];
    // Do any additional setup after loading the view from its nib.
    self.title = @"交易提醒";
    
    // 设置缺省页面 交易提醒缺省
    [self settingNoData];
   
    
    
}

- (void)settingNoData
{
    UIImageView *imgWithoutNodata = [UIImageView new];
    [self.view addSubview:imgWithoutNodata];
    imgWithoutNodata.image = [UIImage imageNamed:@"交易提醒缺省"];
    WS(myself);
    [imgWithoutNodata mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(myself.view);
        make.centerY.mas_equalTo(myself.view).offset(-80*REM);
    }];
    UILabel *lWithoutNoData = [UILabel new];
    [self.view addSubview:lWithoutNoData];
    lWithoutNoData.textAlignment = 1;
    lWithoutNoData.text = @"您暂时还没有收到交易提醒";
    lWithoutNoData.font = [UIFont systemFontOfSize:15];
    lWithoutNoData.textColor = [UIColor colorWithHexString:WORDCOLOR];
    [lWithoutNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imgWithoutNodata);
        make.top.equalTo(imgWithoutNodata.mas_bottom).offset(20*REM);
        
    }];
    
    
    [RACObserve(self, dataArr)subscribeNext:^(NSArray *arr) {
        
        if (arr.count == 0) {
            
            [self.view bringSubviewToFront:imgWithoutNodata];
            [self.view bringSubviewToFront:lWithoutNoData];
            
        } else {
            [self.view sendSubviewToBack:imgWithoutNodata];
            [self.view sendSubviewToBack:lWithoutNoData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
      [[RootInstance shareRootInstance].rootDic removeObjectForKey:@"信鸽推送交易提醒"];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
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
