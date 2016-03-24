//
//  UCarBCarInfoTypeViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoTypeViewController.h"

/**< Cell */
#import "UCarBCarInfoMustHaveTableViewCell.h"
#import "UCarBCarInfoNameLabelTableViewCell.h"

/**< Model*/
#import "UCarBCarInfoTypeModel+UCarBCarInfo.h"

/**< PUSH*/
#import "UCarBCarinfoAllType.h"
#import "UCarBInfoChooseViewController.h"

#import "UCarBCarInfoChooseSecondTypeViewController.h"

@interface UCarBCarInfoTypeViewController () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong)UITableView *tableViewUcarBCarInfoType;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end


static NSString *const reuseMustHaveCell  = @"UCarBCarInfoMustHaveTableViewCell";
static NSString *const reuseNameLabelCell = @"UCarBCarInfoNameLabelTableViewCell";
@implementation UCarBCarInfoTypeViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

//    self.tableViewUcarBCarInfoType = nil;
    self.title = @"选择品牌";
    self.view.backgroundColor = BACKGROUNDCOLOR;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetWork];
}




#pragma mark ConfigNetwork
- (void)configNetWork
{
    NSDictionary *headerDictory   = @{@"Uid":[UserMangerDefaults UidGet]};
    NSString *carSourceCategoryId = [NSString stringWithFormat:@"%@",self.carSourceCategoryId];
    [UCarBCarInfoTypeModel GETUCarBCarInfoType:^(id returnValue) {
    self.dataSource               = returnValue;
    [self.view addSubview:self.tableViewUcarBCarInfoType];
    [self configLayout];
   [self.tableViewUcarBCarInfoType reloadData];
    } Failure:^(id error) {

    } headerDictory:headerDictory carSourceCategoryId:carSourceCategoryId];
}


#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _dataSource.count + 1;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_dataSource == nil || indexPath.row == _dataSource.count) {
            UCarBCarInfoMustHaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseMustHaveCell forIndexPath:indexPath];
            cell.titleLabel.text = @"设置常用的发布品牌";
            cell.titleImageView.image = [UIImage imageNamed:@"iconfont_orange"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else  {
            UCarBCarInfoNameLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseNameLabelCell forIndexPath:indexPath];
            UCarBCarInfoTypeModel_datalist *model  = [_dataSource objectAtIndex:indexPath.row];
            cell.titleLabel.text = model.firstWord;
            cell.carNameLabel.text = model.name;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else {
    UCarBCarInfoMustHaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseMustHaveCell forIndexPath:indexPath];
    cell.titleImageView.image = [UIImage imageNamed:@"iconfont_red"];
    cell.titleLabel.text = @"全部品牌";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}


#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        UCarBCarinfoAllType *allTypeViewController = [[UCarBCarinfoAllType alloc] init];
        allTypeViewController.carSourceCategoryId = self.carSourceCategoryId;
        [self.navigationController pushViewController:allTypeViewController animated:YES];
    } else
    
    if (indexPath.section == 0 && indexPath.row == [_dataSource count]) {
        UCarBInfoChooseViewController *ucarBInfoChooseViewController = [[UCarBInfoChooseViewController alloc] init];
        ucarBInfoChooseViewController.carSourceCategoryId = self.carSourceCategoryId;
        ucarBInfoChooseViewController.refreash = ^(NSInteger refreash){
            if (refreash == 1) {
                [self configNetWork];
            }
        };
        [self.navigationController pushViewController:ucarBInfoChooseViewController animated:YES];
    }
    else {
    // 二级页面
    
    UCarBCarInfoChooseSecondTypeViewController *uCarBCarInfoChooseSecondTypeVC = [[UCarBCarInfoChooseSecondTypeViewController alloc] init];
    UCarBCarInfoTypeModel_datalist *model = [_dataSource objectAtIndex:indexPath.row];
    uCarBCarInfoChooseSecondTypeVC.brandID = model.brandId;
    uCarBCarInfoChooseSecondTypeVC.carSourceCategoryId = [NSString stringWithFormat:@"%@",self.carSourceCategoryId];
    [self.navigationController pushViewController:uCarBCarInfoChooseSecondTypeVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}


#pragma mark AutoLayout
- (void)configLayout
{
    WS(weakSelf);
    [weakSelf.tableViewUcarBCarInfoType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}


#pragma mark SET/GET
- (UITableView *)tableViewUcarBCarInfoType
{
    if (_tableViewUcarBCarInfoType == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoMustHaveTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseMustHaveCell];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarInfoNameLabelTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseNameLabelCell];
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        _tableViewUcarBCarInfoType = tempTableView;
    }
    return _tableViewUcarBCarInfoType;
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
