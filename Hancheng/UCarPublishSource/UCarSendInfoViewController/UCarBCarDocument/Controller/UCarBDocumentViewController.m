//
//  UCarBDocumentViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBDocumentViewController.h"
#import "UCarBOrderTypePriceTableViewCell.h"
#import "UCarBCarDocumentModel+Add.h"
#import "UCarBCarSourceLocationViewController.h"

@interface UCarBDocumentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableviewDocument;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *const reuseDocument = @"UCarBOrderTypePriceTableViewCellDocument";

@implementation UCarBDocumentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title  = @"选择手续";
    self.view.backgroundColor = BACKGROUNDCOLOR;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableviewDocument];
    [self configNetwork];
}


#pragma mark AutoLayout
- (void)configLayout
{
    WS(weakSelf);
    [weakSelf.tableviewDocument mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

#pragma mark ConfigNetWork
- (void)configNetwork
{
    [UCarBCarDocumentModel GETDocumentListwithcarSourceCategoryId:self.carSourceCategoryId success:^(id returnValue) {
        NSMutableArray *tempArray = returnValue;
        
        self.dataSource = [NSMutableArray arrayWithObjects:@[@"不填"],tempArray,@[@"自定义手续时间"], nil];
        [self configLayout];
    } failure:^(id error) {
        
    }];
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        UCarBCarDocumentModel_dataList *model = _dataSource[indexPath.section][indexPath.row];
        self.documentListBlock(model.name, model.valueId);
        [self.navigationController popViewControllerAnimated:YES];
    } else if (indexPath.section == 0) {
        NSString *name = _dataSource[indexPath.section][indexPath.row];
        self.documentListBlock(name, nil);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UCarBCarSourceLocationViewController *diyTime = [[UCarBCarSourceLocationViewController alloc] init];
        diyTime.title = @"手续";
        diyTime.tipString = @"      请输入自定义手续时间, 年. 月. 日\n";
        diyTime.placeString = @"请输入自定义手续时间";
        [self.navigationController pushViewController:diyTime animated:YES];
    }
}


#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBOrderTypePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseDocument];
    if (indexPath.section == 1) {
        UCarBCarDocumentModel_dataList *model = _dataSource[indexPath.section][indexPath.row];
        cell.guidePrice.text = model.name;
    } else {
        cell.guidePrice.text = _dataSource[indexPath.section][indexPath.row];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


#pragma mark Setter/Getter
-(UITableView *)tableviewDocument
{
    if (_tableviewDocument == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBOrderTypePriceTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseDocument];
        _tableviewDocument = tempTableView;
    }
    return _tableviewDocument;
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
