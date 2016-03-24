
//
//  ShoppingPartGoodsAllViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingPartGoodsAllViewController.h"
#import "ShoppingPartGoodsViewController.h"
#import "UCarShoppingOrderTableViewCell.h"
#import "UCarShoppingMainViewSectionF25.h"
#import "ShoppingNetwork.h"
#import "UCarBGetGoodsPartsListF74.h"
#import <MJRefresh.h>
#import "ShoppingPartDetailViewController.h"

static NSString *const reuseCell = @"UCarShoppingOrderTableViewCell";
@interface ShoppingPartGoodsAllViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewAllGoods;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger starstNum;
@property (nonatomic, strong) NSNumber *partTimeID;
@end

@implementation ShoppingPartGoodsAllViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleName;
    // Do any additional setup after loading the view.
    self.starstNum = 0;
    self.partTimeID = self.partID;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(chooseNextType)];
    [self.view addSubview:self.tableViewAllGoods];
    [self configLayout];
    [self configNetwork];
    
    self.tableViewAllGoods.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configNetwork)];
    self.tableViewAllGoods.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


- (void)chooseNextType
{
    ShoppingPartGoodsViewController *presentView = [[ShoppingPartGoodsViewController alloc] init];
    presentView.partID = self.partID;
    presentView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    presentView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    presentView.chooseIDAndName = ^(NSNumber *choosePartID, NSString *chooseName){
        self.partTimeID = choosePartID;
        self.starstNum = 0;
        if ([chooseName isEqualToString:@"全部"]) {
            self.title = self.titleName;
        } else {
            self.title = chooseName;
        }
        [self configNetwork];
    };
    
    [self presentViewController:presentView animated:YES completion:nil];
}

#pragma mark 默认数据
- (void)loadMoreData
{
    ++self.starstNum;
    [self removePlaceHolder];
    NSDictionary *params = @{@"id":self.partTimeID,@"pageSize":@"20",@"startNum":[NSString stringWithFormat:@"%ld",(long)self.starstNum]};
    WS(weakSelf)
    [ShoppingNetwork GETGoodsPartsListAllParams:params successBlk:^(id returnValue) {
        NSMutableArray *temArr = [(NSArray *)returnValue mutableCopy];
        if (temArr.count == 0) {
            [weakSelf.tableViewAllGoods.mj_footer endRefreshingWithNoMoreData];
        } else {
            [weakSelf.tableViewAllGoods.mj_footer endRefreshing];
        }
        [weakSelf.dataSource addObjectsFromArray:temArr];
        if (self.dataSource.count == 0) {
            [weakSelf showUnInfo];
            return ;
        } else {
            [weakSelf.tableViewAllGoods reloadData];
        }
    } failureBlk:^(id error) {
        [weakSelf.tableViewAllGoods.mj_footer endRefreshing];
    }];
}

- (void)configNetwork
{
    //    id 一级分类的ID（主键） pageSize 显示的信息数  startNum 分页起始数
    
    WS(weakSelf);
    [self removePlaceHolder];
    if ([self.partTimeID isEqualToNumber:self.partID]) {
        self.starstNum = 0;
        NSDictionary *params = @{@"id":self.partID,@"pageSize":@"20",@"startNum":[NSString stringWithFormat:@"%ld",(long)self.starstNum]};
        [ShoppingNetwork GETGoodsPartsListAllParams:params successBlk:^(id returnValue) {
            NSMutableArray *temArr = [(NSArray *)returnValue mutableCopy];
            [self.tableViewAllGoods.mj_header endRefreshing];
            if (temArr.count == 0) {
                [weakSelf.tableViewAllGoods.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.tableViewAllGoods.mj_footer endRefreshing];
            }
            _dataSource = nil;
            [weakSelf.dataSource addObjectsFromArray:temArr];
            if (self.dataSource.count == 0) {
                [weakSelf showUnInfo];
            }
            [weakSelf.tableViewAllGoods reloadData];
        } failureBlk:^(id error) {
            
        }];
    } else {
        NSDictionary *params = @{@"categoryId":self.partTimeID,@"pageSize":@"20",@"startNum":[NSString stringWithFormat:@"%ld",(long)self.starstNum]};
        [ShoppingNetwork GETUCarMarkerGoodSPartsListParams:params successBlk:^(id returnValue) {
            NSMutableArray *temArr = [(NSArray *)returnValue mutableCopy];
            NSLog(@"----%@",_partTimeID);
            WS(weakSelf)
            _dataSource = nil;
            [weakSelf.dataSource addObjectsFromArray:temArr];
            if (self.dataSource.count == 0) {
                [self showUnInfo];
            }
            [self.tableViewAllGoods.mj_header endRefreshing];
            [weakSelf.tableViewAllGoods reloadData];
        } faliureBlk:^(id error) {
            [self.tableViewAllGoods.mj_header endRefreshing];
        }];
    }
}

#pragma mark tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarShoppingMainViewSectionF25_datalist *model = [self.dataSource objectAtIndex:indexPath.section];
    ShoppingPartDetailViewController *detailViewController = [[ShoppingPartDetailViewController alloc] initWithNibName:NSStringFromClass([ShoppingPartDetailViewController class]) bundle:nil];
    detailViewController.partDetailID = model.id;
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarShoppingOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    cell.model = [self.dataSource objectAtIndex:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

#pragma mark AutoLayout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewAllGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}


#pragma mark SET/GET
-(UITableView *)tableViewAllGoods
{
    if (_tableViewAllGoods == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarShoppingOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseCell];
        _tableViewAllGoods = tempTableView;
    }
    return _tableViewAllGoods;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        NSMutableArray *tempArray = [NSMutableArray array];
        _dataSource = tempArray;
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removePlaceHolder
{
    UIImageView *image = [self.tableViewAllGoods viewWithTag:10000];
    UILabel *label = [self.tableViewAllGoods viewWithTag:10001];
    [image removeFromSuperview];
    [label removeFromSuperview];
}

- (void)showUnInfo
{
    WS(weakSelf)

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"无检索结果"]];
    [self.tableViewAllGoods addSubview:imageView];
    imageView.tag = 10000;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.centerY.mas_equalTo(weakSelf.view).offset(-40);
    }];
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    infoLabel.textColor = HEXCOLOR(0x999999);
    infoLabel.text = @"没有检索到相关商品";
    infoLabel.font = [UIFont systemFontOfSize:14];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.tag = 10001;
    [self.tableViewAllGoods addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(15);
        make.left.and.right.mas_equalTo(weakSelf.view);
    }];
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
