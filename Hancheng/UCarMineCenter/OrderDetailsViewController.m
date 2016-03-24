//
//  OrderDetailsViewController.m
//  Hancheng
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 Tony. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "UCarHaveSendViewController.h"
#import "CancleViewController.h"
/**< Model*/
#import "C_67Model+NetAction.h"
#import "C_86Model.h"
/**< Cell*/
#import "UCarOrderStateTableViewCell.h"
#import "UCarOrderDetailHeaderTableViewCell.h"
#import "UCarOrderDetailSection2HeaderTableViewCell.h"
#import "UCarOrderDealMoneryTableViewCell.h"
#import "ShoppingPartDetailViewController.h"



static NSString *const reuseOrderStateCell = @"UCarOrderStateTableViewCell";
static NSString *const reuseDetailHeader0Cell = @"UCarOrderDetailHeaderTableViewCell";
static NSString *const reuseDetailHeader2Cell = @"UCarOrderDetailSection2HeaderTableViewCell";
static NSString *const reuseOrderDealCell = @"UCarOrderDealMoneryTableViewCell";

@interface OrderDetailsViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIButton *cancelButton;
}

@property (strong, nonatomic)  UITableView *tableViewOrderDetail;
@property (nonatomic, strong) C_67Model *model67;
@property (nonatomic, strong) C_86Model *model86;
@property (nonatomic, strong) NSNumber *cancelOrderID;

@end

@implementation OrderDetailsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"订单详情";
    
//    1-代表配件订单信息C86，0-代表车品订单信息C67
    
    if ([self.type isEqualToString:@"0"]) {
        [self getNetDataC67];
         }
    if ([self.type isEqualToString:@"1"]) {
        [self getNetDataC86];
        
    }
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];

   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UCarHaveSendViewController *carDetailVC = [[UCarHaveSendViewController alloc]init];
//    carDetailVC.carID = myself.model.goodsId;
//    carDetailVC.pageState = 3;
//    [myself.navigationController pushViewController:carDetailVC animated:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"交易说明"] style:UIBarButtonItemStylePlain target:self action:@selector(itemAction)];
    
    
    // 不要在多次执行的方法里面创建视图和添加视图
    cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:cancelButton];
}

//交易流程
- (void)itemAction
{
    Class cls = NSClassFromString(@"TradeDescriptionViewController");
    [self.navigationController pushViewController:cls.new animated:true];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     // 由于不需要显示价格，做此修改 源代码：if (section == 0 || section == 1)
    
    if ([self.type isEqualToString:@"0"]) {
        if (section == 0 || section == 1) {
            return 1;
        } else {
            return self.model67.orderStatus.count + 1;
        }
    } else {
        if (section == 0 ) {
            return 1;
        } else {
            return self.model86.orderStatus.count + 1;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 由于不需要显示价格，做此修改 源代码：return 3;
    if ([self.type isEqualToString:@"1"]) {
        return 2;
    } else {
        return 3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 修改标注 ：删除部分 ：
    /*
     else if (indexPath.section == 1) {
     return 45;
     }
     */
    if ([self.type isEqualToString:@"1"]) {
        if (indexPath.section == 0) {
            return 75;
        }
        else if (indexPath.section == 1 && indexPath.row == 0) {
            return 45;
        } else {
            return 60;
        }
    } else
        if (indexPath.section == 0) {
            return 75;
        }
        else if (indexPath.section == 1) {
            return 45;
        }
        else if (indexPath.section == 2 && indexPath.row == 0) {
            return 45;
        } else {
            return 60;
        }
    
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
    /*
     删除部分：
     else if (indexPath.section == 1) {
     cellDealMoney.infoLabel.text = [NSString stringWithFormat:@"%@元",self.model67.earnest];
     return cellDealMoney;
     }
     */

    UCarOrderStateTableViewCell        *cellOrder     = [tableView dequeueReusableCellWithIdentifier:reuseOrderStateCell];
    UCarOrderDetailHeaderTableViewCell *cellSection0  = [tableView dequeueReusableCellWithIdentifier:reuseDetailHeader0Cell];
    UCarOrderDetailSection2HeaderTableViewCell *cellSection2  = [tableView dequeueReusableCellWithIdentifier:reuseDetailHeader2Cell];
    UCarOrderDealMoneryTableViewCell   *cellDealMoney = [tableView dequeueReusableCellWithIdentifier:reuseOrderDealCell];
    cellOrder.selectionStyle = UITableViewCellSelectionStyleNone;
    cellSection2.selectionStyle = UITableViewCellSelectionStyleNone;
    cellDealMoney.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self.type isEqualToString:@"0"]) {
        if (indexPath.section == 0) {
            cellSection0.orderDetailTitleLabel.text = [NSString stringWithFormat:@"%@ 【%@】",self.model67.goodsName, self.model67.spotsName];
            cellSection0.orderDetailDealLabel.text = [NSString stringWithFormat:@"成交价:%@万元",self.model67.price];
            cellSection0.orderDetailFrontMoneryLabel.text = [NSString stringWithFormat:@"定金:%@元",self.model67.earnest];
            return cellSection0;
        }
        else if (indexPath.section == 1) {
            cellDealMoney.infoLabel.text = [NSString stringWithFormat:@"%@元",self.model67.earnest];
            return cellDealMoney;
        }
        else if (indexPath.section == 2 && indexPath.row == 0) {
            cellSection2.orderDetailTitleLabel.text = [NSString stringWithFormat:@"订单:%@",self.model67.order_sn];
            if (self.model67.maxName) {
                cellSection2.orderStateString = self.model67.maxName;
            } else {
                cellSection2.orderStateString = @"";
            }
            return cellSection2;
        } else {
            C_67ModelChild *tempModel  = self.model67.orderStatus[indexPath.row - 1];
            cellOrder.orderDetailTimeLabel.text = tempModel.modify_datetime;
            cellOrder.orderDetailCarState.text = tempModel.statusName;
            if (self.model67.orderStatus.count == 1) {
                cellOrder.pageState = 5;
            } else {
                if (indexPath.row == 1) {
                    cellOrder.pageState = 2;
                } else if (indexPath.row  == self.model67.orderStatus.count && indexPath.row != 1) {
                    cellOrder.pageState = 4;
                } else {
                    cellOrder.pageState = 1;
                }
            }
            return cellOrder;
        }
    } else {
        if (indexPath.section == 0) {
            cellSection0.orderDetailTitleLabel.text = [NSString stringWithFormat:@"%@",self.model86.goodsPartsName];
            cellSection0.orderDetailDealLabel.text = [NSString stringWithFormat:@"成交价:%@元",self.model86.price];
            cellSection0.orderDetailFrontMoneryLabel.text = @"";
            return cellSection0;
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            cellSection2.orderDetailTitleLabel.text = [NSString stringWithFormat:@"订单:%@",self.model86.orderSn];
            if (self.model86.maxName) {
                cellSection2.orderStateString = self.model86.maxName;
            } else {
                cellSection2.orderStateString = @"";
            }
            return cellSection2;
        } else {
            C_86ModelChild *tempModels  = self.model86.orderStatus[indexPath.row - 1];
            cellOrder.orderDetailTimeLabel.text = tempModels.modifyDatetime;
            cellOrder.orderDetailCarState.text = tempModels.statusName;
            if (self.model86.orderStatus.count == 1) {
                cellOrder.pageState = 5;
            } else {
                if (indexPath.row == 1) {
                    cellOrder.pageState = 2;
                } else if (indexPath.row  == self.model86.orderStatus.count && indexPath.row != 1) {
                    cellOrder.pageState = 4;
                } else {
                    cellOrder.pageState = 1;
                }
            }
            return cellOrder;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.type isEqualToString:@"0"]) {
        if (indexPath.row == 0 && indexPath.section == 0) {
            UCarHaveSendViewController *detailVC = [[UCarHaveSendViewController alloc] init];
            detailVC.carID = self.model67.goodsId;
            detailVC.pageState = PageFromStateFromWhy;
            detailVC.is_showBottom = YES;
       
            
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    } else {
        if (indexPath.row == 0 && indexPath.section == 0) {
            ShoppingPartDetailViewController *orderVC = [[ShoppingPartDetailViewController alloc] initWithNibName:NSStringFromClass([ShoppingPartDetailViewController class]) bundle:nil];
            orderVC.partDetailID = self.model86.goodsPartsId;
            orderVC.is_show = YES;
            [self.navigationController pushViewController:orderVC animated:YES];
        }
    }
    
}
#pragma mark Network
- (void)getNetDataC86
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:[NSString stringWithFormat:@"/api/ucarMy/getGoodsPartsOrderDetails?orderId=%@",self.orderId] WithParamDic:@{@"orderId":self.orderId}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"86 : %@",request.responseJSONObject);
        self.model86 = [C_86Model new];
        self.model86 = [C_86Model modelWithJSON:request.responseBody[@"data"]];
        C_86ModelChild *childModel = [self.model86.orderStatus firstObject];
        self.cancelOrderID = childModel.goodsPartsOrderStatusId;
        if (![self.cancelOrderID isEqualToNumber:@3]) {
            self.model67 = [[C_67Model alloc] init];
            self.model67.maxName = @"交易关闭";
        }
        [self.view addSubview:self.tableViewOrderDetail];
        [self.tableViewOrderDetail reloadData];
        [self configLayout];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void)getNetDataC67
{
    [C_67Model handleWithSuccessBlock:^(id returnValue) {
        self.model67 = returnValue;
        C_67ModelChild *childModel = [self.model67.orderStatus lastObject];
        self.cancelOrderID = childModel.orderStatusId;
        [self.view addSubview:self.tableViewOrderDetail];
        [self.tableViewOrderDetail reloadData];
        [self configLayout];
        // 处理按钮
        if ([self.model67.maxName isEqualToString:@"交易关闭"]) {
            cancelButton.alpha = 0 ;
        }
    } WithFailureBlock:^(id error) {
    } WithorderId:self.orderId];
}

#pragma mark AutoLayout
- (void)configLayout
{
 
    WS(weakSelf)

    if (![self.model67.maxName isEqualToString:@"交易关闭"] || self.model86.orderStatus.count == 0) {
        [cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor whiteColor];
        [cancelButton setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelPage) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(@50);
        }];
    } else {
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(@0);
        }];
    }
    
    [weakSelf.tableViewOrderDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(weakSelf.view);
        make.bottom.equalTo(cancelButton.mas_top);
    }];
    
    
}

- (void)cancelPage
{
    NSLog(@"cancelOrder : %@",self.cancelOrderID);
    CancleViewController *cancleVC = [[CancleViewController alloc] init];
    cancleVC.orderId = self.orderId;
    if ([self.type isEqualToString:@"0"]) {
        cancleVC.statu = @"0";
    }
    if ([self.type isEqualToString:@"1"]) {
        cancleVC.statu = @"1";
    }
    [self.navigationController pushViewController:cancleVC animated:YES];

}

#pragma mark SET/GET
- (UITableView *)tableViewOrderDetail
{
    if (_tableViewOrderDetail == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarOrderStateTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseOrderStateCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarOrderDetailHeaderTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseDetailHeader0Cell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarOrderDetailSection2HeaderTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseDetailHeader2Cell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarOrderDealMoneryTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseOrderDealCell];
        _tableViewOrderDetail = tempTableView;
    }
    return _tableViewOrderDetail;
}

- (NSNumber *)cancelOrderID
{
    if (_cancelOrderID == nil) {
        NSNumber *tempNumber = [NSNumber new];
        _cancelOrderID = tempNumber;
    }
    return _cancelOrderID;
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
