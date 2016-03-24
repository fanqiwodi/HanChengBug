//
//  UPircesViewController.m
//  Hancheng
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//




#import "UPircesViewController.h"
#import "UPricesDataController.h"
#import "ReactiveCocoa.h"
#import "MJRefresh.h"
#import "IsPayViewController.h"
#import "IsPayChildTableViewCell.h"
#import "G_77_Model.h"
#import "UCarHaveSendViewController.h"
#import "C_58_infoModel.h"
#import "C_58_infoModel+NetAction.h"
#import "LGAlertView.h"
#import "VIPViewController.h"
#import <libkern/OSAtomic.h>
#import "RDVTabBarController.h"
@interface UPircesViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    OSSpinLock _lock;
    UIView *hideView;
    RDVTabBarController *_rdvTabbarVC;

}
@property (nonatomic, strong) UITableView *myTableView; // 列表视图
@property (nonatomic, strong) UPricesDataController *viewModel; // 列表的dataResource
@property (nonatomic, strong) NSNumber *statu; // 区分当前登陆用户是否是付费用户
@end

@implementation UPircesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    
    [self refreshIsPay];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"U特价";
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
    UCARNSUSERDEFULTS(userDefaults)
    self.statu = [userDefaults objectForKey:UCARIS_PAY];
    if ([self.statu isEqualToNumber:@1]) {
        IsPayViewController *isPayVC = [[IsPayViewController alloc] init];
        
        [self.navigationController addChildViewController:isPayVC];
        
     
    } else if ([self.statu isEqualToNumber:@0]) {
        [self initTableView];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(again) name:@"重新刷新页面" object:nil];


    

}

- (void)初始化表
{
    
}

- (void)again
{
    _rdvTabbarVC = (RDVTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    dispatch_sync_on_main_queue(^{
        // 由于后台修改用户付费,需要重新加载页面
        _rdvTabbarVC.selectedIndex = 0;
        _rdvTabbarVC.selectedIndex = 1;
    });
}


- (void)refreshIsPay
{

    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
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
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        UCARNSUSERDEFULTS(userDefaults)
        self.statu = [userDefaults objectForKey:UCARIS_PAY];
        if ([self.statu isEqualToNumber:@1]) {

            [self.myTableView removeFromSuperview];
            IsPayViewController *isPayVC = [[IsPayViewController alloc] init];
        
            [self.navigationController addChildViewController:isPayVC];
        
        
        }
        
        else if ([self.statu isEqualToNumber:@0]) {
                [self initTableView];
        }
    });
}

- (void)initTableView
{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-114) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView setTableFooterView:[UIView new]];
    [self.myTableView registerNib:[UINib nibWithNibName:@"IsPayChildTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IsPayChildTableViewCell class])];
    
    
    
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.viewModel refresh];
    }];
    
    self.myTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [self.viewModel loadmore];
    }];
    
  [self.view addSubview:self.myTableView];
    
    // 为了后台修改会员之后重新加载立即刷新页面,需要对视图重新做处理.
    NSMutableArray *arr = [NSMutableArray array];
   for (UIView *tableView in self.view.subviews) {
        if ([NSStringFromClass([tableView class])isEqualToString:@"UITableView"]) {
            [arr addObject:tableView];
        }
    }
    for (NSInteger i = 0; i < arr.count - 1; i++) {
        UIView *view = arr[i];
        [view removeFromSuperview];
    }
    
    G_77_Model *model;
    self.viewModel = [[UPricesDataController alloc] initWithG_77Model:model];
    [RACObserve(self.viewModel, containerModelList) subscribeNext:^(id x) {
        
        [self updateView];
        
    }];

    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = BACKGROUNDCOLOR;
}

- (void)updateView
{
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
   
    if ([self.viewModel.model.isPay isEqualToNumber:@1]) {
        [self.myTableView removeFromSuperview];
        
        IsPayViewController *isPayVC = [[IsPayViewController alloc] init];
        
        [self.navigationController addChildViewController:isPayVC];
    
    }
    [self.myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = self.viewModel.containerModelList.count;
   
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IsPayChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IsPayChildTableViewCell class]) forIndexPath:indexPath];
    G_77_Model_son *modelSon = self.viewModel.containerModelList[indexPath.row];
    [cell setModelG77:modelSon];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280*REM;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    G_77_Model_son *modelSon = self.viewModel.containerModelList[indexPath.row];
    UCarHaveSendViewController *carDeatilVC = [[UCarHaveSendViewController alloc] init];
    carDeatilVC.carID = modelSon.myID;
    carDeatilVC.pageState = 3;
    carDeatilVC.fromVC = @"u特价";
    if ([modelSon.isLock isEqualToNumber:@1]) {
        [self.navigationController pushViewController:carDeatilVC animated:YES];
    } else {

        
        LGAlertView *alt  = [[LGAlertView alloc]initWithTitle:@"提示" message:@"抱歉！特价只对会员可见！" style:0 buttonTitles:@[@"成为会员"]cancelButtonTitle:@"取消" destructiveButtonTitle:nil];
        alt.buttonsBackgroundColorHighlighted = [UIColor colorWithHexString:@"ff5000"];
        alt.buttonsTitleColor = [UIColor colorWithHexString:@"ff5000"];
        alt.cancelButtonTitleColor = [UIColor colorWithHexString:@"999999"];
       [alt showAnimated:YES completionHandler:^{
           
       }];
        alt.actionHandler = ^(LGAlertView *alertView, NSString *title, NSUInteger index){
            
            if (index==0) {
                VIPViewController *VIPvc = [[VIPViewController alloc] init];
                [self.navigationController pushViewController:VIPvc animated:YES];
            }
        };
        
   
        
        
    }
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
