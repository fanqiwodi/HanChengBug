//
//  BuyorSellOrderViewController.m
//  Hancheng
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BuyorSellOrderViewController.h"
#import "UCarBuyOrSellOrderTableViewCell.h"
#import "C_47_BuyCarModel+NetAction.h"
#import "OrderDetailsViewController.h"

static NSString *const reuseCell = @"UCarBuyOrSellOrderTableViewCell";

@interface BuyorSellOrderViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableViewOrder;
@property (nonatomic, strong) C_47_BuyCarModel *model;
@end

@implementation BuyorSellOrderViewController

- (void)getNetData
{
    // 0是买车订单, 1 是卖车订单
    NSInteger i = [self.statu integerValue];
    switch (i) {
        case 0:
        {
            [C_47_BuyCarModel handleWithSuccessBlock:^(id returnValue) {
                self.model = returnValue;
                if (self.model.datalist.count == 0) {
                    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"订单缺省"]];
                    backImage.center = CGPointMake(SCREENWIDTH / 2, SCREENHEIGHT / 2 - 77);
                    [self.view addSubview:backImage];
                    UILabel *l = [UILabel new];
                    [self.view addSubview:l];
                    [l mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.mas_equalTo(backImage);
                        make.top.equalTo(backImage.mas_bottom).offset(20*REM);
                    }];
                    l.text = @"您暂无订单";
                    l.font = [UIFont systemFontOfSize:15];
                    l.textColor = [UIColor colorWithHexString:WORDCOLOR];
                } else {
                    [self.view addSubview:self.tableViewOrder];
                    [self configLayout];
                }
            } WithFailureBlock:^(id error) {
                NSLog(@"错误%@", error);
            } WithC47orC48:@"C47" WithHeader:@{@"Uid":[UserMangerDefaults UidGet]}];
        }
            break;
        case 1:
        {
            [C_47_BuyCarModel handleWithSuccessBlock:^(id returnValue) {
                self.model = returnValue;
                if (self.model.datalist.count == 0) {
                    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"订单缺省"]];
                    backImage.center = CGPointMake(SCREENWIDTH / 2, SCREENHEIGHT / 2 - 77);
                    [self.view addSubview:backImage];
                    UILabel *l = [UILabel new];
                    [self.view addSubview:l];
                    [l mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.mas_equalTo(backImage);
                        make.top.equalTo(backImage.mas_bottom).offset(20*REM);
                    }];
                    l.text = @"您暂无订单";
                    l.font = [UIFont systemFontOfSize:15];
                    l.textColor = [UIColor colorWithHexString:WORDCOLOR];
                    
                } else {
                    [self.view addSubview:self.tableViewOrder];
                    [self configLayout];
                }
            } WithFailureBlock:^(id error) {
                NSLog(@"错误%@", error);
            } WithC47orC48:@"C48" WithHeader:@{@"Uid":[UserMangerDefaults UidGet]}];
        }
            break;
        default:
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBuyOrSellOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    C_47_BuyCarModel_Chlid *model = self.model.datalist[indexPath.section];
    cell.model = model;
    cell.orderStateString = model.maxName;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 119;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C_47_BuyCarModel_Chlid *model = self.model.datalist[indexPath.section];
    OrderDetailsViewController *orderDVC = [[OrderDetailsViewController alloc] init];
    orderDVC.orderId = model.orderId;
    orderDVC.type = model.type;
    [self.navigationController pushViewController:orderDVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNetData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

#pragma mark Layout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

#pragma mark SET/GET
- (UITableView *)tableViewOrder
{
    if (_tableViewOrder == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.dataSource = self;
        tempTableView.delegate = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBuyOrSellOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseCell];
        _tableViewOrder = tempTableView;
    }
    return _tableViewOrder;
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
