//
//  ShoppingMakeSureViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingMakeSureViewController.h"
#import "ShoppingPartDetailOrderTableViewCell.h"
#import "ShoppingNetwork.h"
#import "UCarShopBuyButtonView.h"

@interface ShoppingMakeSureViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewBuy;

@end

@implementation ShoppingMakeSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认购买";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableViewBuy];
    [self configLayou];
}


- (void)configLayou
{
    WS(weakSelf)
    [weakSelf.tableViewBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

- (void)makeSureBuy
{
    [ShoppingNetwork POSTUCarMarketAddOrdersPartsParams:@{@"goodsPartsId":self.partDetailID} HeaderUid:[UserMangerDefaults UidGet] successBlk:^(id returnValue) {
        NSDictionary *blkDic = returnValue;
        NSNumber *codeID = [blkDic objectForKey:@"code"];
        if ([codeID isEqualToNumber:@0]) {
            [self showHint:@"预定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *msg = [blkDic objectForKey:@"msg"];
            [self showHint:msg];
        }
    } failureBlk:^(id error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingPartDetailOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    cell.infoLabel.text = self.infoName;
    cell.infoPriceLabel.text = self.infoPrice;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UCarShopBuyButtonView *footerView = [[[NSBundle mainBundle]loadNibNamed:@"UCarShopBuyButtonView" owner:nil options:nil] lastObject];
    [footerView.sendButton addTarget:self action:@selector(makeSureBuy) forControlEvents:UIControlEventTouchUpInside];
    
    return footerView;
}


- (UITableView *)tableViewBuy
{
    if (_tableViewBuy == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingPartDetailOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"reuseCell"];
        tempTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        _tableViewBuy = tempTableView;
    }
    return _tableViewBuy;
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
