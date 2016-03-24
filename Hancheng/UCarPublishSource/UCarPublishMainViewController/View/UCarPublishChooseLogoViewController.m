//
//  UCarPublishChooseLogoViewController.m
//  Hancheng
//
//  Created by Tony on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarPublishChooseLogoViewController.h"
#import "UCarBCarInfoTypeModel+UCarBCarInfo.h"
#import "UCarBCarInfoMustHaveTableViewCell.h"
#import "UCarBCarInfoNameLabelTableViewCell.h"

static NSString *const reuseMustHaveCell = @"UCarBCarInfoMustHaveTableViewCell";
static NSString *const reuseNameLabelCell = @"UCarBCarInfoNameLabelTableViewCell";

@interface UCarPublishChooseLogoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewChooseLogo;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation UCarPublishChooseLogoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = @"选择品牌";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configNetwork];
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        self.backBrandID(@0);
    }
    
    if (indexPath.section == 1) {
        UCarBCarInfoTypeModel_datalist *model = [self.dataSource objectAtIndex:indexPath.row + 1];
        self.backBrandID(model.brandId);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TableDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return self.dataSource.count - 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataSource.count > 0) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBCarInfoMustHaveTableViewCell *mustHaveCell = [tableView dequeueReusableCellWithIdentifier:reuseMustHaveCell];
    UCarBCarInfoNameLabelTableViewCell *nameLabelCell = [tableView dequeueReusableCellWithIdentifier:reuseNameLabelCell];
    if (indexPath.section == 0) {
        mustHaveCell.titleLabel.text = @"不限品牌";
        mustHaveCell.titleImageView.image = [UIImage imageNamed:@"iconfont_red"];
        return mustHaveCell;
    } else {
        UCarBCarInfoTypeModel_datalist *model = [self.dataSource objectAtIndex:indexPath.row + 1];
        nameLabelCell.titleLabel.text = model.firstWord;
        nameLabelCell.carNameLabel.text = model.name;
        return nameLabelCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

#pragma mark configNetwork
- (void)configNetwork
{
    [UCarBCarInfoTypeModel GETUCarGetSearchBrand:[UserMangerDefaults UidGet] successblk:^(id returnValue) {
        self.dataSource = returnValue;
        [self.view addSubview:self.tableViewChooseLogo];
        [self configLayout];
    } failureBlk:^(id error) {
        
    }];
}

#pragma mark ConfigLayout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewChooseLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

#pragma mark SET/GET
- (UITableView *)tableViewChooseLogo
{
    if (_tableViewChooseLogo == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoMustHaveTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseMustHaveCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoNameLabelTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseNameLabelCell];
        _tableViewChooseLogo = tempTableView;
    }
    return _tableViewChooseLogo;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _dataSource = tempArray;
    }
    return _dataSource;
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
