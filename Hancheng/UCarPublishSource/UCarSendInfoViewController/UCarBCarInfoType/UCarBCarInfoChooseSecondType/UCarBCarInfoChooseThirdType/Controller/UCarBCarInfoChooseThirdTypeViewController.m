//
//  UCarBCarInfoChooseThirdTypeViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseThirdTypeViewController.h"
#import "UCarBCarInfoChooseSecondTypeTableViewCell.h" //自定义
#import "UCarBCarInfoChooseThirdTypeTableViewCell.h" //普通

#import "UCarBCarInfoChooseThirdTypeMode+Add.h"
#import "UCarSendInforViewController.h"

#import "UCarBCarCustomCarInfoTypeViewController.h"

static NSString *const reuseChooseSecondTableViewCell = @"UCarBCarInfoChooseSecondTypeTableViewCellh";
static NSString *const reuseChooseThirdTableViewCell  = @"UCarBCarInfoChooseThirdTypeTableViewCellh";

@interface UCarBCarInfoChooseThirdTypeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewUCarInfoChooseThirdType;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation UCarBCarInfoChooseThirdTypeViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"选择车型";
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetwork];
}


#pragma mark ConfigNetWork
- (void)configNetwork
{
    [UCarBCarInfoChooseThirdTypeMode GETUCarBCarInfoChooseThirdTypeGoodsCategoryIdLevel2:self.goodsCategoryIdLevel2 carSourceCategoryId:self.carSourceCategoryId header:[UserMangerDefaults UidGet] successGET:^(id returnValue) {
        self.dataSource = returnValue;
        [self.view addSubview:self.tableViewUCarInfoChooseThirdType];
        [self configLayout];
    } failureGET:^(id error) {
        
    }];
}

#pragma mark tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UCarBCarInfoChooseThirdTypeMode_datalist *model = _dataSource[indexPath.row];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSDictionary *postDic = @{@"goodsCategoryIdLevel2":self.goodsCategoryIdLevel2,@"carSourceCategoryId":self.carSourceCategoryId,@"brandId":self.brandID,@"goodsCategoryIdLevel1":self.goodsCategoryIdLevel1};
       [center postNotificationName:CENTERCARTYPE object:model userInfo:postDic];
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    } else {
        UCarBCarCustomCarInfoTypeViewController *customCarInfoTypeVC = [[UCarBCarCustomCarInfoTypeViewController alloc] initWithNibName:@"UCarBCarCustomCarInfoTypeViewController" bundle:nil];
        customCarInfoTypeVC.goodsCategoryIdLevel1 = self.goodsCategoryIdLevel1;
        customCarInfoTypeVC.goodsCategoryIdLevel2 = self.goodsCategoryIdLevel2;
        customCarInfoTypeVC.carSourceCategoryId = self.carSourceCategoryId;
        customCarInfoTypeVC.brandID = self.brandID;
        [self.navigationController pushViewController:customCarInfoTypeVC animated:YES];
    }
}

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_dataSource count];
    } else {
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UCarBCarInfoChooseThirdTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseChooseThirdTableViewCell forIndexPath:indexPath];
        UCarBCarInfoChooseThirdTypeMode_datalist *model = _dataSource[indexPath.row];
        cell.titleLabel.text = model.name;
        CGFloat price = [model.guidePrice floatValue];
        cell.priceLabel.text = [NSString stringWithFormat:@"%.2f万",price];
        return cell;
    } else {
        UCarBCarInfoChooseSecondTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseChooseSecondTableViewCell forIndexPath:indexPath];
        cell.titleLabel.text = @"自定义车型";
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark AutoLayout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewUCarInfoChooseThirdType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark Set/Get
- (UITableView *)tableViewUCarInfoChooseThirdType
{
    if (_tableViewUCarInfoChooseThirdType == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoChooseSecondTypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseChooseSecondTableViewCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoChooseThirdTypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseChooseThirdTableViewCell];
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViewUCarInfoChooseThirdType = tempTableView;
    }
    return _tableViewUCarInfoChooseThirdType;
}

- (void)dealloc{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
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
