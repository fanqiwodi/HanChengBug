//
//  UCarBCarShowPageDetailTableViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarBCarShowPageDetailTableViewController.h"
#import "UCarConfigureOrderModel+Add.h"
#import "UCarBOrderTypePriceTableViewCell.h"

@interface UCarBCarShowPageDetailTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewDetail;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation UCarBCarShowPageDetailTableViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBOrderTypePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    UCarConfigureOrderModel_datalist *model = _dataSource[indexPath.row];
    cell.guidePrice.text = model.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view).insets(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
}

- (void)configNetwork
{
    [UCarConfigureOrderModel GETBrightPackageListAllbrightPackageId:[NSString stringWithFormat:@"%@",self.brightPackageId] success:^(id returnValue) {
        self.dataSource = returnValue;
        NSLog(@"++++%ld",self.dataSource.count);
        [self.tableViewDetail reloadData];
    } failure:^(id error) {
        
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetwork];
    
    [self.view addSubview:self.tableViewDetail];
    [self configLayout];
}


- (UITableView *)tableViewDetail
{
    if (_tableViewDetail == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBOrderTypePriceTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"reuseCell"];
        _tableViewDetail = tempTableView;
    }
    return _tableViewDetail;
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
