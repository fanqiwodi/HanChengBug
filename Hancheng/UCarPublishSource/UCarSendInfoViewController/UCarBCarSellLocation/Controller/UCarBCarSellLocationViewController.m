//
//  UCarBCarSellLocationViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarSellLocationViewController.h"
#import "UCarBCarSellLocationModel+Add.h"

#import "UCarBOrderTypePriceTableViewCell.h"
#import "UCarBCarSourceLocationViewController.h"

@interface UCarBCarSellLocationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewLocation;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

static NSString *const reuseCell = @"UCarBOrderTypePriceTableViewCell";
@implementation UCarBCarSellLocationViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = WARTHOUSE_XSQY;
    self.view.backgroundColor = BACKGROUNDCOLOR;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableViewLocation];
    
    [self configNetwork];
}


- (void)configLayout
{
    WS(weakSelf);
    [weakSelf.tableViewLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.tableViewLocation reloadData];
}

#pragma ConfigNetWorking
- (void)configNetwork
{
    [UCarBCarSellLocationModel GETSalArea:[UserMangerDefaults UidGet] success:^(id returnValue) {
        NSArray *tempData = returnValue;
        self.dataSource = [NSMutableArray arrayWithObjects:@[@"不限区域"],tempData,@[@"自定义销售区域"], nil];
        [self configLayout];
    } failure:^(id error) {
        
    }];
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        UCarBCarSourceLocationViewController *diySalArea = [[UCarBCarSourceLocationViewController alloc] initWithNibName:NSStringFromClass([UCarBCarSourceLocationViewController class]) bundle:nil];
        diySalArea.title = WARTHOUSE_XSQY;
        diySalArea.placeString = [NSString stringWithFormat:@"请输入自定义%@",WARTHOUSE_XSQY];
        diySalArea.tipString = @"      为更好的进行销售, 建议填写销售区域, 如 “东区” 或 “浙江” 或 “杭州” 或 “东疆库“ .";
        [self.navigationController pushViewController:diySalArea animated:YES];
    } else {
        self.salAreaBlock(_dataSource[indexPath.section][indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBOrderTypePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.guidePrice.text = _dataSource[indexPath.section][indexPath.row];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

- (UITableView *)tableViewLocation
{
    if (_tableViewLocation == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.showsHorizontalScrollIndicator = NO;
        tempTableView.showsVerticalScrollIndicator = NO;
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBOrderTypePriceTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseCell];
        _tableViewLocation = tempTableView;
    }
    return _tableViewLocation;
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
