//
//  UCarBCarInfoChooseSecondTypeViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseSecondTypeViewController.h"
#import "UCarBCarInfoChooseSecondTypeTableViewCell.h"

#import "UCarBCarInfoChooseSecondTypeModel+Add.h"
#import "UCarBCarInfoChooseSecondTypeModel.h"

#import "UCarBHeaderView.h"
#import "UCarBCarInfoChooseThirdTypeViewController.h"

static NSString *const reuseInfoChooseSecond = @"UCarBCarInfoChooseSecondTypeTableViewCell";

@interface UCarBCarInfoChooseSecondTypeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewChooseSecondType;
@property (nonatomic, strong)NSArray *dataSource;

@end

@implementation UCarBCarInfoChooseSecondTypeViewController

- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"选择车系";
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetWork];
}

- (void)configNetWork
{
    [UCarBCarInfoChooseSecondTypeModel GETSecondChooseType:self.brandID carSourceCategoryId:self.carSourceCategoryId success:^(id returnValue) {
        self.dataSource = returnValue;
        [self.view addSubview:self.tableViewChooseSecondType];
        [self configLayout];
    } failure:^(id error) {

    }];

}
#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBCarInfoChooseSecondTypeModel_datalist *model = _dataSource[1][indexPath.section][indexPath.row];
    UCarBCarInfoChooseThirdTypeViewController *thirdChooseType = [[UCarBCarInfoChooseThirdTypeViewController alloc] init];
    thirdChooseType.carSourceCategoryId = self.carSourceCategoryId;
    thirdChooseType.goodsCategoryIdLevel1 = model.goodsCategoryIdLevel1;
    thirdChooseType.goodsCategoryIdLevel2 = [NSString stringWithFormat:@"%@",model.goodsCategoryIdLevel2];
    thirdChooseType.brandID = self.brandID;
    
    [self.navigationController pushViewController:thirdChooseType animated:YES];
}

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[1][section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBCarInfoChooseSecondTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseInfoChooseSecond forIndexPath:indexPath];
    UCarBCarInfoChooseSecondTypeModel_datalist *model = _dataSource[1][indexPath.section][indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", model.name];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSource[0] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UCarBCarInfoChooseSecondTypeModel_datalist *model =  _dataSource[0][section];
    UCarBHeaderView *headerView = [UCarBHeaderView instanceView:model.name];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

#pragma mark AutoLayout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewChooseSecondType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark Set/Get
- (UITableView *)tableViewChooseSecondType
{
    if (_tableViewChooseSecondType == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoChooseSecondTypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseInfoChooseSecond];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        _tableViewChooseSecondType = tempTableView;
    }
    return _tableViewChooseSecondType;
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
