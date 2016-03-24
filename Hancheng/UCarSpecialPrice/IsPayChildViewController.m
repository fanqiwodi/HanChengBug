//
//  IsPayChildViewController.m
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IsPayChildViewController.h"
#import <ReactiveCocoa.h>
#import "G_78_Model.h"
#import <MJRefresh.h>
#import "IsPayChildTableViewCell.h"
#import "UCarHaveSendViewController.h"
#import "ShoppingPartGoodsViewController.h"
@interface IsPayChildViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    G_78_Model *model_g78;
    NSMutableArray *arr;
    GetWithHeaderAPI *API;
}
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, assign)NSInteger startNum;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSNumber *tempID;
@end

@implementation IsPayChildViewController

- (void)headerRefresh
{

    [arr removeAllObjects];
    self.startNum = 0;
}

- (void)initData
{
   self.url = [NSString stringWithFormat:@"/api/ucarSpecial/getSpecialList?startNum=%lu&pageSize=20&brandId=%@", self.startNum, self.brandId];
    arr = [NSMutableArray array];

}

- (void)initTableView
{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-55) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView setTableFooterView:[UIView new]];
    [self.view addSubview:self.myTableView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"IsPayChildTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IsPayChildTableViewCell class])];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRefresh];
    }];
    self.myTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.startNum ++ ;
    }];
    
    

    @weakify(self);
    [RACObserve(self, startNum)subscribeNext:^(id x) {
        @strongify(self);
        API = [[GetWithHeaderAPI alloc] initWithUrl:self.url header:@{@"Uid": [UserMangerDefaults UidGet]}];


        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            model_g78 = [G_78_Model modelWithJSON:request.responseBody[@"data"]];

           if ([model_g78.totalCount integerValue] > arr.count) {
                [arr addObjectsFromArray:model_g78.specialList];
                [self.myTableView.mj_footer endRefreshing];
           }
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            [self.myTableView reloadData];
            NSLog(@"-   %@    -",self.url);
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"错误%lu", request.responseStatusCode);
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IsPayChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IsPayChildTableViewCell class]) forIndexPath:indexPath];
    if (arr.count != 0) {
          G_78_Model_son *modelSon = arr[indexPath.row];
         [cell setModel:modelSon]; 
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280*REM;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    G_78_Model_son *modelSon;
    if (arr.count == 0) {
        
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            model_g78 = [G_78_Model modelWithJSON:request.responseBody[@"data"]];
            
            if ([model_g78.totalCount integerValue] > arr.count) {
                [arr addObjectsFromArray:model_g78.specialList];
                [self.myTableView.mj_footer endRefreshing];
            }
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            [self.myTableView reloadData];
            NSLog(@"-   %@    -",self.url);
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"错误%lu", request.responseStatusCode);
        }];
        
    } else {
    modelSon = arr[indexPath.row];
    UCarHaveSendViewController *carDetailVC = [[UCarHaveSendViewController alloc] init];
    carDetailVC.carID = modelSon.myID;
    carDetailVC.pageState = PageFromStateFromWhy;
    carDetailVC.fromVC = @"u特价";
    [self.navigationController pushViewController:carDetailVC animated:YES];
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"保存数组" object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选车型" style:UIBarButtonItemStylePlain target:self action:@selector(selectedAction:)];
 
    // Do any additional setup after loading the view.
    
    self.title = self.titleName;
    
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    myQueue.name = @"保存数组用的";
    myQueue.maxConcurrentOperationCount = 2;
    myQueue.qualityOfService = NSOperationQueuePriorityHigh;

    [[NSNotificationCenter defaultCenter]addObserverForName:@"保存数组" object:nil queue:myQueue usingBlock:^(NSNotification * _Nonnull note) {

        arr = arr.mutableCopy;
    }];
    
}


- (void)selectedAction:(UIBarButtonItem *)item
{
    self.tempID = @0;
    ShoppingPartGoodsViewController *shoppingVC = [[ShoppingPartGoodsViewController alloc] init];
    shoppingVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    shoppingVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shoppingVC.statuStr = @"UcarSpecial";
    shoppingVC.partID = self.brandId;
    
    
    shoppingVC.block = ^(NSIndexPath *path, NSString *name){
        if (path.row == 0) {
            self.title = self.titleName;
        } else {
            self.title = name;
        }
    };
    
    @weakify(self);
  
    [RACObserve(shoppingVC, selectID)subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x != nil) {
             [arr removeAllObjects];
        }
        if (x == nil) {
            self.url = [NSString stringWithFormat:@"/api/ucarSpecial/getScreenList?pageSize=20&startNum=0&goodCategoryIdLevel2=%@",self.tempID];
        } else {
        self.tempID = x;
        self.url = [NSString stringWithFormat:@"/api/ucarSpecial/getScreenList?pageSize=20&startNum=0&goodCategoryIdLevel2=%@",self.tempID];
            if ([self.brandId isEqualToNumber:x]) {
                
                // 如果点击全部特殊处理，时间太久了，不知道当时怎么设计的。
                self.url = [NSString stringWithFormat:@"/api/ucarSpecial/getSpecialList?startNum=0&pageSize=20&brandId=%@",self.tempID];
            }
            
        self.startNum = 0;
        }
    }];
    
    [self presentViewController:shoppingVC animated:YES completion:nil];
    
}


SettingBottomBar

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
