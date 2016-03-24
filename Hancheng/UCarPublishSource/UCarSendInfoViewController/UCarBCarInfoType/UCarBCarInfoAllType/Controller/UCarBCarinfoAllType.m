//
//  UCarBCarinfoAllType.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarinfoAllType.h"
#import "UCarBCarInfoChooseSecondTypeViewController.h"

/** Cell*/
#import "UCarBCarInfoTypeTableViewCell.h"

/** NetWork*/
#import "UCarBInfoChooseTypeModel+UCarBInfoChooseTypeModeAdd.h"

/** Header*/
#import "UCarBHeaderView.h"
/** 索引*/
#import "BDKCollectionIndexView.h"


static NSString *const reuseInfoTypeCell = @"UCarBCarInfoTypeTableViewCell";
@interface UCarBCarinfoAllType ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewinfoAllType;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation UCarBCarinfoAllType

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"全部品牌";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetWork];
}


#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBCarInfoChooseSecondTypeViewController *secondViewController = [[UCarBCarInfoChooseSecondTypeViewController alloc] init];
    UCarBInfoChooseTypeModel_datalist *modelDataList = _dataSource[indexPath.section];
    UCarBInfoChooseTypeModel_datalist_value *model = [modelDataList.value objectAtIndex:indexPath.row];
    secondViewController.brandID = model.brandId;
    secondViewController.carSourceCategoryId = [NSString stringWithFormat:@"%@",self.carSourceCategoryId];
    
    [self.navigationController pushViewController:secondViewController animated:YES];
    
}



#pragma mark ConfigNetWork
- (void)configNetWork
{
    NSString *tempCarSourceCategoryID = [NSString stringWithFormat:@"%@",self.carSourceCategoryId];
    [UCarBInfoChooseTypeModel GETUCarBInfoChooseType:^(id returnValue) {
        
        self.dataSource = returnValue;
        [self.view addSubview:self.tableViewinfoAllType];
        [self configLayout];
        [self initIndexView];
        
    } failure:^(id error) {
        
    } carSourceCategoryId:tempCarSourceCategoryID userID:[UserMangerDefaults UidGet]];

}

#pragma mark ConfigLayout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewinfoAllType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UCarBInfoChooseTypeModel_datalist *model = _dataSource[section];
    return model.value.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBCarInfoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseInfoTypeCell forIndexPath:indexPath];
    UCarBInfoChooseTypeModel_datalist *modelDataList = _dataSource[indexPath.section];
    UCarBInfoChooseTypeModel_datalist_value *model = [modelDataList.value objectAtIndex:indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.name];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UCarBInfoChooseTypeModel_datalist *modelDataList = _dataSource[section];
    UCarBHeaderView *headerView = [UCarBHeaderView instanceView:modelDataList.name];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}



#pragma mark 索引
- (void)initIndexView
{
    NSMutableArray *indexArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        UCarBInfoChooseTypeModel_datalist *model = _dataSource[i];
        [indexArray addObject:model.name];
    }
    BDKCollectionIndexView *indexView = [BDKCollectionIndexView indexViewWithFrame:CGRectZero indexTitles:indexArray];
    indexView.translatesAutoresizingMaskIntoConstraints = NO;   // auto layout
    [indexView addTarget:self action:@selector(indexViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    indexView.titleColor = [UIColor colorWithHexString:@"ccced1"];
    [self.view insertSubview:indexView aboveSubview:self.tableViewinfoAllType];
    WS(weakself);
    [indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).with.offset(-5);
        make.top.equalTo(weakself.view);
        make.bottom.equalTo(weakself.view);
        make.width.equalTo(@20);
    }];
    
    
}

- (void)indexViewValueChanged:(BDKCollectionIndexView *)sender {
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:sender.currentIndex];
    [self.tableViewinfoAllType scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


#pragma mark SET/GET
- (UITableView *)tableViewinfoAllType
{
    if (_tableViewinfoAllType == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoTypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseInfoTypeCell];
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        _tableViewinfoAllType = tempTableView;
    }
    return _tableViewinfoAllType;
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
