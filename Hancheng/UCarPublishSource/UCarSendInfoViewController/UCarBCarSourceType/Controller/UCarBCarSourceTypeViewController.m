//
//  UCarBCarSourceTypeViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarSourceTypeViewController.h"
#import "UCarBOrderTypePriceTableViewCell.h"
#import "BaseModel+UCarBCarSourceTypeModel.h"
#import "UCarBCarSourceTypeModel.h"
static NSString *const reuseUCarBSourceType = @"UCarBOrderTypeTableViewCell";

@interface UCarBCarSourceTypeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewSourceType;
@property (nonatomic, strong)NSMutableArray *dateSource;

@end

@implementation UCarBCarSourceTypeViewController


- (void)viewWillAppear:(BOOL)animated
{
    self.title = WARTHOUSE_CYLX;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [super viewWillAppear:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetwork];
}

#pragma mark configNetWork
- (void)configNetwork
{
    NSDictionary *headerDic = @{@"Uid":[UserMangerDefaults UidGet]};
    [UCarBCarSourceTypeModel GETUCarBSourceTypeNetWrokBlock:^(id returnValue) {
        self.dateSource = returnValue;
        if (_dateSource.count == 0) {
            [self showHint:@"程序员GG正在紧急维护服务器"];
        }
        [self.view addSubview:self.tableViewSourceType];
        [self configLayout];
        [self.tableViewSourceType reloadData];
    } FailureBlock:^(id error) {
        
    } header:headerDic];
}


#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarSendInfoModel_datalist *model = _dateSource[indexPath.section][indexPath.row];
    self.sourceTypeBlock(model);
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dateSource.count;
}


#pragma mark TableViewDatesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dateSource[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBOrderTypePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseUCarBSourceType forIndexPath:indexPath];
    UCarSendInfoModel_datalist *model = _dateSource[indexPath.section][indexPath.row];
    cell.guidePrice.text = [NSString stringWithFormat:@"%@-%@",model.name,model.spotsName];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectZero];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark AutoLayout
- (void)configLayout
{
    WS(weakSelf);
    [weakSelf.tableViewSourceType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark SETTER/GETTER
- (UITableView *)tableViewSourceType
{
    if (_tableViewSourceType == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBOrderTypePriceTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseUCarBSourceType];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        _tableViewSourceType = tempTableView;
    }
    return _tableViewSourceType;
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
