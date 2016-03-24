//
//  ShopViewController.m
//  Hancheng
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ShopViewController.h"
#import "UCarShoppingTableViewCell.h"
#import "UCarShoppingMoreInfoTableViewCell.h"
#import "UCarShoppingOrderTableViewCell.h"
#import "MJRefresh.h"
#import "UCarBCarTitleView.h"
#import "ShoppingPartDetailViewController.h"
#import "ShoppingNetwork.h"
#import "UCarShoppingMainViewModel.h"
#import "UCarShoppingMainViewSectionF25.h"
#import "UIImageView+WebCache.h"
#import "ShoppingPartGoodsAllViewController.h"
#import "HeaderLineView.h"
#import "NetErrorView.h"
#import "AppDelegate.h"

static NSString *const reuseShoppingType = @"UCarShoppingTableViewCell";
static NSString *const reuseShoppingMore = @"UCarShoppingMoreInfoTableViewCell";
static NSString *const reuseOrderCell = @"UCarShoppingOrderTableViewCell";


@interface ShopViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableViewShopping;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NetErrorView *errorView;

@end

@implementation ShopViewController

#pragma mark LiftCycle
- (void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:YES];
    [self creatAllView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"商场";
}

#pragma mark 首次请求数据

- (void)loadNewData
{
    self.pageSize = 0;
    [self configNetworking:0];
}
- (void)loadMoreData
{
    ++self.pageSize;
    [self configNetworking:self.pageSize];
}

- (void)configNetworking:(NSInteger)pageSize
{
    if (pageSize == 0) {
        WS(weakSelf)
        [ShoppingNetwork GetShopMainViewData:^(id returnValue) {
            if (returnValue) {
                NSMutableArray *resultArray = returnValue;
                NSArray *sectionOne = [resultArray objectAtIndex:0];
                NSArray *sectionTwo = [resultArray objectAtIndex:1];
                [weakSelf.dataSource replaceObjectAtIndex:0 withObject:sectionOne];
                [weakSelf.dataSource replaceObjectAtIndex:1 withObject:sectionTwo];
                
                [ShoppingNetwork GetShopMainViewSectionData:^(id returnValue) {
                    NSMutableArray *pageSizeArray  = returnValue;
                    [weakSelf.dataSource replaceObjectAtIndex:2 withObject:pageSizeArray];
                    
                    [weakSelf.view addSubview:self.tableViewShopping];
                    [weakSelf configLayout];
                    
                    [weakSelf.tableViewShopping reloadData];
                    [weakSelf.tableViewShopping.mj_header endRefreshing];
                } failure:^(id error) {
                    [weakSelf.tableViewShopping.mj_header endRefreshing];
                    
                    [self netError];

                } pageSize:0];
                
            }
        } failure:^(id error) {
            [self.tableViewShopping.mj_header endRefreshing];
            [self netError];
        }];
    } else {
        WS(weakSelf)
        [ShoppingNetwork GetShopMainViewSectionData:^(id returnValue) {
            NSMutableArray *pageSizeArray  = returnValue;
            if (pageSizeArray.count == 0) {
                [weakSelf.tableViewShopping.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            weakSelf.dataSource = [self replaceDataSourceAdd:pageSizeArray];
            [weakSelf.tableViewShopping reloadData];
            [weakSelf.tableViewShopping.mj_footer endRefreshing];
            
        } failure:^(id error) {
            [weakSelf.tableViewShopping.mj_footer endRefreshingWithNoMoreData];
            [self netError];
        } pageSize:pageSize];
    }
}

- (void)netError
{
    
        self.errorView = [[NetErrorView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 49 - 15 - self.navigationController.navigationBar.frame.size.height)];
        _errorView.backgroundColor = [UIColor whiteColor];
        [_errorView.button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_errorView];
    

}
- (void)creatAllView
{
    self.pageSize = 0;
    [self configNetworking:self.pageSize];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    self.tableViewShopping.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableViewShopping.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

}
- (void)back:(UIButton *)button
{
    [self.errorView removeFromSuperview];
    [self creatAllView];
    
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        NSMutableArray *dataOrderArray  = [self.dataSource objectAtIndex:2];
        UCarShoppingMainViewSectionF25_datalist *model  = [dataOrderArray objectAtIndex:indexPath.row];
        ShoppingPartDetailViewController *detailViewController = [[ShoppingPartDetailViewController alloc] initWithNibName:NSStringFromClass([ShoppingPartDetailViewController class]) bundle:nil];
        detailViewController.partDetailID = model.id;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


#pragma mark TableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UCarShoppingTableViewCell *cellType = [tableView dequeueReusableCellWithIdentifier:reuseShoppingType];
        cellType.chooseTypeID = ^(NSNumber *partID, NSString *titleName) {
            WS(weakSelf)
            if ([partID isEqualToNumber:@0]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在完善, 敬请期待!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return ;
            }
            ShoppingPartGoodsAllViewController *secondChooseType = [[ShoppingPartGoodsAllViewController alloc] init];
            secondChooseType.partID = partID;
            secondChooseType.titleName = titleName;
            [weakSelf.navigationController pushViewController:secondChooseType animated:YES];
            
        };
        cellType.dataSource = [[self.dataSource objectAtIndex:0][0] mutableCopy];
        cellType.selectionStyle = UITableViewCellSelectionStyleDefault;
        return cellType;
    } else if (indexPath.section == 1) {
        UCarShoppingMoreInfoTableViewCell *cellMoreInfo = [tableView dequeueReusableCellWithIdentifier:reuseShoppingMore];
        cellMoreInfo.dataSource = [[self.dataSource objectAtIndex:1][0] mutableCopy];
        cellMoreInfo.chooseIDAndName = ^(NSNumber *carID, NSString *title){
//            WS(weakSelf)
//            ShoppingPartGoodsAllViewController *secondChooseType = [[ShoppingPartGoodsAllViewController alloc] init];
//            secondChooseType.partID = carID;
//            secondChooseType.titleName = title;
//            [weakSelf.navigationController pushViewController:secondChooseType animated:YES];
        };
        cellMoreInfo.selectionStyle = UITableViewCellSelectionStyleDefault;
        return cellMoreInfo;
    } else {
        UCarShoppingOrderTableViewCell *cellOrder = [tableView dequeueReusableCellWithIdentifier:reuseOrderCell];
        NSMutableArray *dataOrderArray  = [self.dataSource objectAtIndex:2];
        cellOrder.model  = [dataOrderArray objectAtIndex:indexPath.row];
        cellOrder.selectionStyle = UITableViewCellSelectionStyleDefault;
        return cellOrder;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        UCarBCarTitleView *header = [[UCarBCarTitleView alloc] init];
        header.titleLabel.text = @"热门推荐";
        return header;
    } else {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 45;
    }
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 108 *LAYOUT_SIZE;
    } else if (indexPath.section == 1) {
        return 205 *LAYOUT_SIZE;
    } else {
        return 90*LAYOUT_SIZE ;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    } else {
        return 0.1;
    }
}



#pragma mark Layout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewShopping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}



#pragma mark 加载增加数据
- (NSMutableArray *)replaceDataSourceAdd:(NSMutableArray *)array
{
    if (array != nil) {
        NSMutableArray *tempThreeSection = [self.dataSource objectAtIndex:2];
        for (UCarShoppingMainViewSectionF25_datalist *model in array) {
            [tempThreeSection addObject:model];
        }
        [self.dataSource replaceObjectAtIndex:2 withObject:tempThreeSection];
    }
    return _dataSource;
}



#pragma mark Setter/Getter
- (UITableView *)tableViewShopping
{
    if (_tableViewShopping == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarShoppingTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseShoppingType];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarShoppingMoreInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseShoppingMore];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarShoppingOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseOrderCell];
        _tableViewShopping = tempTableView;
    }
    return _tableViewShopping;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        NSMutableArray *sectionOneArray = [NSMutableArray new];
        NSMutableArray *sectionTwoArray = [NSMutableArray new];
        NSMutableArray *sectionThreeArray = [NSMutableArray new];
        NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:sectionOneArray,sectionTwoArray,sectionThreeArray, nil];
        _dataSource = tempArray;
    }
    return _dataSource;
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
