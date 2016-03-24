//
//  UCarBCatOutsideViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCatOutsideViewController.h"
#import "UCarBCarInfoTypeTableViewCell.h"
#import "UCarBCarOutSideColorModel+Add.h"
#import "UCarBCarColorDIYViewController.h"

@interface UCarBCatOutsideViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewColor;
@property (nonatomic, strong)NSArray *dataSource;

@property (nonatomic, strong) NSString *diyName;

@end


static NSString *const reuseColorCell = @"UCarBCarInfoTypeTableViewCellColor";
@implementation UCarBCatOutsideViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    if (self.viewState == 0) {
        self.title = WARTHOUSE_WGYS;
    } else {
        self.title = WARTHOUSE_NSYS;
    }
    

    [super viewWillAppear:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.viewState == 0) {
        [self configNetworkOutColor];
    } else if (self.viewState == 1) {
        [self configNetworkInSideColor];
    }
}



#pragma mark ConfigNetwork
- (void)configNetworkOutColor
{
    if (self.viewState == 0) {
        self.diyName = @"自定义外观颜色";
    } else {
        self.diyName = @"自定义内饰颜色";
    }
    

    if (self.goodsTemplateId != nil) {
        [UCarBCarOutSideColorModel GETOutSideColorListgoodsTemplateId:[NSString stringWithFormat:@"%@", self.goodsTemplateId] uid:[UserMangerDefaults UidGet] successBlock:^(id returnValue) {
            NSArray *tempArr = returnValue;
            self.dataSource = [NSArray arrayWithObjects:tempArr,@[self.diyName], nil];
            [self.view addSubview:self.tableViewColor];
            [self configLayout];
        } failure:^(id error) {
            
        }];
    } else {
        self.dataSource = [NSArray arrayWithObjects:@[self.diyName], nil];
        [self.view addSubview:self.tableViewColor];
        [self configLayout];
    }
}

- (void)configNetworkInSideColor
{
    if (self.viewState == 0) {
        self.diyName = @"自定义外观颜色";
    } else {
        self.diyName = @"自定义内饰颜色";
    }
    
    
    if (self.goodsTemplateId != nil) {
        [UCarBCarOutSideColorModel GETInSideColorListgoodsTemplateId:[NSString stringWithFormat:@"%@", self.goodsTemplateId] uid:[UserMangerDefaults UidGet] successBlock:^(id returnValue) {
            NSArray *tempArr = returnValue;
            self.dataSource = [NSArray arrayWithObjects:tempArr,@[self.diyName], nil];
            [self.view addSubview:self.tableViewColor];
            [self configLayout];
        } failure:^(id error) {
            
        }];
    } else {
        self.dataSource = [NSArray arrayWithObjects:@[self.diyName], nil];
        [self.view addSubview:self.tableViewColor];
        [self configLayout];
    }
    
}

#pragma mark ConfigAutoLayout
- (void)configLayout
{
    WS(weakSelf);
    [weakSelf.tableViewColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *colorStrs = _dataSource[indexPath.section][indexPath.row];
    if ([colorStrs isEqualToString:self.diyName]) {
        UCarBCarColorDIYViewController *colorViewController = [[UCarBCarColorDIYViewController alloc] init];
        colorViewController.viewState = self.viewState;
        [self.navigationController pushViewController:colorViewController animated:YES];
    } else {
        self.blockColor(colorStrs);
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
    UCarBCarInfoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseColorCell];
    cell.titleLabel.text = _dataSource[indexPath.section][indexPath.row];
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

#pragma mark Setter/ getter
- (UITableView *)tableViewColor
{
    if (_tableViewColor == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoTypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseColorCell];
        _tableViewColor = tempTableView;
    }
    return _tableViewColor;
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
