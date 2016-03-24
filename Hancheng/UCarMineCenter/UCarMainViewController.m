//
//  UCarMainViewController.m
//  Hancheng
//
//  Created by Tony on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WHY_ActionSheet.h"


#import "UCarMainViewController.h"
#import "UIView+BadgedView.h"
// Cell 们
#import "UCarMainHeaderView.h"
#import "UCarMainAskForCheckTableViewCell.h"
#import "UCarThreeTypeChooseTableViewCell.h"
#import "UCarMineSellOrBuyTableViewCell.h"
#import "ReactiveCocoa.h"
#import <libkern/OSAtomic.h>
#import "DBHelper.h"


#import "C_58_infoModel+NetAction.h"
#import "MessageViewController.h"
#import "RemindofDealViewController.h"
#import "BuyorSellOrderViewController.h"
#import "SettingViewController.h"
#import "VIPViewController.h"
#import "UCarSelfInfoViewController.h"
#import "UCarUserLicenseViewController.h"
#import "NetErrorView.h"

static NSString *const reuseAskForCheckCell = @"UCarMainAskForCheckTableViewCell";
static NSString *const reuseThreeTypeCell = @"UCarThreeTypeChooseTableViewCell";
static NSString *const reuseSellOrBuyCell = @"UCarMineSellOrBuyTableViewCell";
static NSString *const reuseCell = @"UITableviewcell";


typedef NS_ENUM(NSInteger,PageState) {
    pageStateNoNetwork= 0, // 无网络
    pageStateSelfSeller,   // 汽车经纪人
    pageStateCompanySeller,// 企业经销商
    pageStateSelfSource,   // 个人车源商
    pageStateCompanySource,// 企业车源商
};
@interface UCarMainViewController () <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *msgArr;
}

@property (nonatomic, strong) UITableView *tableviewMine;
@property (nonatomic, strong) NSArray *dataSourceName;
@property (nonatomic, strong) C_58_infoModel *model;
@property (nonatomic, assign) PageState pageState;
@property (nonatomic, strong) UCarMainHeaderView *headerView;
@property (nonatomic, strong) NetErrorView *errorView;

@end

@implementation UCarMainViewController
{
    OSSpinLock _lock;
    FMDatabase *db;
    
    NSInteger showMessage; // 显示红点 我的消息
    NSInteger showBussiness; // 交易提醒
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self creatAllView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
}

- (void)configLayout:(NSInteger)offsetNumber
{
    WS(weakSelf)
    [weakSelf.tableviewMine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.headerView.bottom);
        make.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    WS(weakSelf)
    CGFloat tempFrameHeight = scrollView.contentOffset.y;
    if (tempFrameHeight > 3) {
        tempFrameHeight = 3;
        weakSelf.tableviewMine.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        @autoreleasepool {
            [weakSelf.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(126 - tempFrameHeight / 3);
            }];
        }
    } else
    if (tempFrameHeight < -20) {
        tempFrameHeight = -20;
        weakSelf.tableviewMine.contentOffset = CGPointMake(0, -20);
        @autoreleasepool {
            [weakSelf.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(126 - tempFrameHeight);
            }];
        }
    } else {
        @autoreleasepool {
            [weakSelf.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(126 - tempFrameHeight);
            }];
        }
    }
}
#pragma mark Network
- (void)getNetData_c58
{

    WS(weakSelf)
    [C_58_infoModel handleWithSuccessBlock:^(id returnValue) {
        weakSelf.model= [C_58_infoModel new];
        weakSelf.model = returnValue;
        weakSelf.pageState = [weakSelf.model.role_id integerValue]; // 判断用户类型
        
        dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(global, ^{
            OSSpinLockLock(&_lock);
            C_58_infoModel *model_c58 = returnValue;
            [NSKeyedArchiver archiveRootObject:model_c58 toFile:RETURNPATH(@"modelc58.model")];
        });
        
        NSArray *tempArray = [NSArray new];
        if ([self.model.is_auth isEqualToString:@"0"]) {
            // 未认证, 1表示已经认证
            tempArray = @[@[@"",@""],@[@"我的买车订单",@"我的卖车订单"],@[@"会员服务"],@[@"设置"],@[@""]];
        }
        
        if ([self.model.is_auth isEqualToString:@"1"]) {
            tempArray = @[@[@""],@[@"我的买车订单",@"我的卖车订单"],@[@"会员服务"],@[@"设置"],@[@""]];
        }
        self.dataSourceName = tempArray;
        
        [weakSelf setHeaderView];
        [weakSelf.tableviewMine reloadData];
    } WithFailureBlock:^(id error) {
        weakSelf.pageState = pageStateNoNetwork;
        
        [self netError];
        
    }];
}
- (void)creatAllView
{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    [self getNetData_c58];
    
    [self refreshIsPay];
    
    // 查询
    db = [DBHelper getDataBase:@"systemNoti.db"];
    if ([db open]) {
        
        // 我的消息红点设置
        NSString *countStr = [RootInstance shareRootInstance].rootDic[@"信鸽推送我的信息"];
        
        if (countStr.length > 0) {
            // 出现红点.
            showMessage = 1;
            
        } else {
            // 消失红点.
            showMessage = 0;
        }
        
        // 交易提醒红点设置
        NSString *countStrOfRemind = [RootInstance shareRootInstance].rootDic[@"信鸽推送交易提醒"];
        
        if (countStrOfRemind.length > 0) {
            // 出现红点.
            showBussiness = 1;
            
        } else {
            // 消失红点.
            showBussiness = 0;
        }
        
        [self.tableviewMine reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
        
        FMResultSet *rs = [db executeQuery:@"SELECT Time, Type, Content  FROM SYSNOTI"];
        msgArr = [NSMutableArray array];
        while ([rs next]) {
            NSString *Time = [rs stringForColumn:@"Time"];
            NSString *Type = [rs stringForColumn:@"Type"];
            NSString *Content = [rs stringForColumn:@"Content"];
            NSDictionary *vale = @{@"time" : Time, @"type" : Type, @"content" : Content};
            
            // 按时间先后顺序排列
            if (![Type isEqualToString:@"5"]) {
                [msgArr insertObject:vale atIndex:0];
            }
        }
    }



}

- (void)netError
{
    self.errorView = [[NetErrorView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 49)];
    _errorView.backgroundColor = [UIColor whiteColor];
    [_errorView.button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_errorView];
    


}

- (void)back:(UIButton *)button
{
    [self.errorView removeFromSuperview];
    [self creatAllView];

}
- (void)setHeaderView
{
    // 防止重复添加headerView
    if (self.headerView != nil) {
        [self.headerView removeFromSuperview];
    }
        self.headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([UCarMainHeaderView class]) owner:nil options:nil] lastObject];
        [self.view addSubview:self.headerView];
    [self.headerView.selectedAction addTarget:self action:@selector(personInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    WS(weakself)
    [weakself.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(weakself.view);
        make.height.mas_equalTo(126);
    }];
    self.headerView.nameLabel.text = self.model.nickName;
    self.headerView.companyLabel.text = self.model.company;
    NSArray *imageArry = @[@"",@"ico_qichejingjiren",@"ico_qiyejingxiaoshang",@"ico_gerencheyuanshang",@"ico_qiyecheyuanshang"];
    self.headerView.checkImageView.image = [UIImage imageNamed:[imageArry objectAtIndex:[self.model.role_id integerValue]]];
    
    if ([self.model.is_auth isEqualToString:@"1"] && [self.model.is_pay isEqualToNumber:@1]) {
        self.headerView.is_auth.image = [UIImage imageNamed:@"ico_yirenzheng"];
        self.headerView.is_pay.image = [UIImage imageNamed:@"ico_huiyuan"];
    } else {
        if ([self.model.is_auth isEqualToString:@"1"] && ![self.model.is_pay isEqualToNumber:@1]) {
            self.headerView.is_auth.image = [UIImage imageNamed:@"ico_yirenzheng"];
            self.headerView.is_pay.image = [UIImage new];
        }
        
        if (![self.model.is_auth isEqualToString:@"1"] && [self.model.is_pay isEqualToNumber:@1]) {
            self.headerView.is_auth.image = [UIImage imageNamed:@"ico_huiyuan"];
        }
        
        if (![self.model.is_auth isEqualToString:@"1"] && ![self.model.is_pay isEqualToNumber:@1]) {
            self.headerView.is_pay.image = self.headerView.is_auth.image = [UIImage new];
        }
    }
    [self.view addSubview:self.tableviewMine];
    [self configLayout:126];
}

#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceName[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarMainAskForCheckTableViewCell *askForCheckCell = [tableView dequeueReusableCellWithIdentifier:reuseAskForCheckCell];
    UCarThreeTypeChooseTableViewCell *threeTypeCell = [tableView dequeueReusableCellWithIdentifier:reuseThreeTypeCell];
    UCarMineSellOrBuyTableViewCell *sellOrBuyCell = [tableView dequeueReusableCellWithIdentifier:reuseSellOrBuyCell];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    sellOrBuyCell.unReadString = @"";
    threeTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [threeTypeCell.MyInfoButton addTarget:self action:@selector(MyMessageAction:) forControlEvents:UIControlEventTouchUpInside];
    [threeTypeCell.MyCarSourceButton addTarget:self action:@selector(MyCarSourceAction:) forControlEvents:UIControlEventTouchUpInside];
    [threeTypeCell.BussinessTip addTarget:self action:@selector(MyRemindAction:) forControlEvents:UIControlEventTouchUpInside];
    threeTypeCell.showBussinessDot = showBussiness;
    threeTypeCell.showMessageDot = showMessage;
    if (indexPath.section == 0) {
        if ([self.dataSourceName[0] count] == 2) {
            if (indexPath.row == 0) {
                if ([self.model.role_id isEqualToString:@"1"] || [self.model.role_id isEqualToString:@"3"]) {
                    askForCheckCell.titleLabel.text = @"身份认证, 让买卖更直接!";
                } else {
                    askForCheckCell.titleLabel.text = @"企业认证, 让买卖更直接!";
                }
                return askForCheckCell;
            } else {
                return threeTypeCell;
            }
        } else {
            return threeTypeCell;
        }
    } else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                sellOrBuyCell.lineState = 1;
                sellOrBuyCell.unReadString = [NSString stringWithFormat:@"%@",self.model.buyOrder];
            } else {
                sellOrBuyCell.lineState = 2;
                sellOrBuyCell.unReadString = [NSString stringWithFormat:@"%@",self.model.sellOrder];
            }
        }
        sellOrBuyCell.titleLabel.text = self.dataSourceName[indexPath.section][indexPath.row];
        return sellOrBuyCell;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        NSString *str = [NSString stringWithFormat:@"客服电话:%@", self.model.phone];
        cell.textLabel.text = str.length != 0 ? str : @"";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"239AEC"];
        return cell;
    }
    return nil;
}

// DidSelection
- (void)MyCarSourceAction:(UIButton *)button
{
    RDVTabBarController *_rdvTabbarVC =  (RDVTabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    _rdvTabbarVC.selectedIndex = 2;
}

- (void)MyRemindAction:(UIButton *)button
{
    RemindofDealViewController *remindVC = [[RemindofDealViewController alloc] init];
    [self.navigationController pushViewController:remindVC animated:YES];
}
- (void)MyMessageAction:(UIButton *)button
{
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    messageVC.arr = msgArr;
    [self.navigationController pushViewController:messageVC animated:YES];
}
- (void)personInfoAction:(UIControl *)uicontrol
{
    UCarSelfInfoViewController *personinfoVC = [[UCarSelfInfoViewController alloc]init];
    [self.navigationController pushViewController:personinfoVC animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.dataSourceName[0] count] == 2) {
            if (indexPath.row == 0) {
                NSLog(@"推送到企业认证");
                UCarUserLicenseViewController *licenseVC = [[UCarUserLicenseViewController alloc]init];
                licenseVC.pageState = 1;
                licenseVC.isAuth = self.model.is_auth;
                licenseVC.role_id = self.model.role_id;
                [self.navigationController pushViewController:licenseVC animated:YES];
            } else {
                NSLog(@"什么也不用做");
            }
        }
    } else if (indexPath.section == 1) {
        BuyorSellOrderViewController *buyOrderVC = [[BuyorSellOrderViewController alloc] init];
        switch (indexPath.row) {
            case 0:
                buyOrderVC.statu = @"0";
                buyOrderVC.title = @"我的买车订单";
                [self.navigationController pushViewController:buyOrderVC animated:YES];
                break;
            case 1:
                buyOrderVC.statu = @"1";
                buyOrderVC.title = @"我的卖车订单";
                [self.navigationController pushViewController:buyOrderVC animated:YES];
                break;
            default:
                break;
        }

    } else if (indexPath.section == 2) {
        VIPViewController *vipVC = [[VIPViewController alloc] init];
        [self.navigationController pushViewController: vipVC animated:YES];
    } else if (indexPath.section == 3) {
        SettingViewController *setVC = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
    } else {
        if (self.model.phone.length == 0) {
            UIAlertController *altVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂时无法拨打电话" preferredStyle:UIAlertControllerStyleActionSheet];
            [altVC addAction: [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:altVC animated:YES completion:^{
                
            }];
        } else {
            NSString * str= [NSString stringWithFormat:@"telprompt://%@",self.model.phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
   
        
    }
        [self.tableviewMine reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceName.count;
}


#pragma mark TableDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.dataSourceName[indexPath.section] count] == 2) {
            if (indexPath.row == 0) {
                return 32;
            } else {
                return 93.5;
            }
        } else {
                return 93.5;
        }
    } else {
        return 45;
    }
}


#pragma mark SET/GET
- (UITableView *)tableviewMine
{
    if (_tableviewMine == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = [UIColor clearColor];
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarMainAskForCheckTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseAskForCheckCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarThreeTypeChooseTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseThreeTypeCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarMineSellOrBuyTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseSellOrBuyCell];
        [tempTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCell];
        
        _tableviewMine = tempTableView;
    }
    return _tableviewMine;
}


- (NSArray *)dataSourceName
{
    if (_dataSourceName == nil) {
        NSArray *tempArray = [NSArray new];
        _dataSourceName =  tempArray;
    }
    return _dataSourceName;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_errorView != nil) {
        [_errorView removeFromSuperview];
    }


}


- (void)refreshIsPay
{
    [C_58_infoModel handleWithSuccessBlock:^(id returnValue) {
        C_58_infoModel *model = [C_58_infoModel new];
        model = returnValue;
        UCARNSUSERDEFULTS(userDefaults)
        [userDefaults setObject:model.is_pay forKey:UCARIS_PAY];
        [userDefaults setObject:model.phone forKey:UCARPHONENUMBER];
        [userDefaults setObject:model.is_push forKey:UCARIS_PUSH];
        [userDefaults setObject:model.is_auth forKey:UCARIS_AUTH];
        [userDefaults setObject:model.role_id forKey:UCARROLE_ID];
    } WithFailureBlock:^(id error) {
    }];
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
