//
//  UCarBCarConfigureViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarConfigureViewController.h"
#import "UCarBCarConfigureDetailTableViewCell.h"
#import "UCarBCarConfigureTableViewCell.h"
#import "UCarBHeaderView.h"
#import "UCarBOrderTypePriceTableViewCell.h"

#import "UcarBCarConfigureModel+Add.h"
#import "UCarConfigureOrderModel+Add.h"

#import "UCarBCarSourceLocationViewController.h"
#import "UCarBInputTableViewCell.h"

#import "UCarBCarShowPageDetailTableViewController.h"

static NSString *const reuseConfigDetail = @"UCarBCarConfigureDetailTableViewCell";
static NSString *const reuseConfigOrder = @"UCarBCarConfigureTableViewCell";
static NSString *const reuseDIY = @"UCarBOrderTypePriceTableViewCell";
static NSString *const reuseMoreInfo = @"UCarBInputTableViewCell";

@interface UCarBCarConfigureViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewConfigure;
@property (nonatomic, strong)NSArray *dataSource;

@property (nonatomic, strong)NSArray *detailArray;
@property (nonatomic, strong)NSArray *orderArray;

@property (nonatomic, strong)NSMutableArray *chooseArray;

@property (nonatomic, strong)UITextView *moreInfoTextView;

@end

@implementation UCarBCarConfigureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = @"配置";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo:)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(pushToShowDetail:) name:CENTERDETAILBUTTON object:nil];
    
    if (self.goodsTemplateId != nil) {
        [self configNetwork];
    } else {
        self.dataSource = @[@[@"",@""]];
        [self.view addSubview:self.tableViewConfigure];
        [self configLayout];
    }
}

- (void)pushToShowDetail:(NSNotification *)notification
{
    UCarBCarShowPageDetailTableViewController *detailViewController = [[UCarBCarShowPageDetailTableViewController alloc] init];
    NSInteger index = [notification.object integerValue];
    UcarBCarConfigureModel_datalist *model = self.detailArray[index];
    detailViewController.brightPackageId = model.id;
    detailViewController.title = model.brightPackageName;
    NSLog(@"%@",model.id);
    [self.navigationController pushViewController:detailViewController animated:YES];
}




#pragma mark ConfigNetwoking
- (void)configNetwork
{
    [UcarBCarConfigureModel GETBrightPackageListGoodsTemplateID:[NSString stringWithFormat:@"%@",self.goodsTemplateId] success:^(id returnValue) {
        self.detailArray = returnValue;
        [UcarBCarConfigureModel GETBrightPointsListGoodsTempLateID:[NSString stringWithFormat:@"%@",self.goodsTemplateId] success:^(id returnValue) {
            self.orderArray = returnValue;
            [self StartLayoutTableView];
            } failure:^(id error) {
        }];
    } failure:^(id error) {
    }];
}

- (void)configLayout
{
    WS(weakSelf);
    [weakSelf.tableViewConfigure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (void)saveInfo:(UIBarButtonItem *)button
{
    // 根据选择is_Use字符串0/1判断选择了哪一个 然后取出值返回
    if (self.goodsTemplateId != nil) {
    NSMutableArray *backArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.chooseArray.count; i++) {
        NSMutableArray *tempArray = [self.chooseArray objectAtIndex:i];
        for (NSInteger j = 0; j < tempArray.count; j++) {
            NSString *is_Use = [tempArray objectAtIndex:j];
            if ([is_Use isEqualToString:@"1"]) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:j inSection:i];
                [backArray addObject:index];
            }
        }
    }
    NSMutableString *backShowString = [NSMutableString stringWithString:@""];
    NSMutableString *backPageID = [NSMutableString stringWithString:@""];
    NSMutableString *backID = [NSMutableString stringWithString:@""];
    
    for (NSIndexPath *index in backArray) {
        if (index.section == 0) {
        UcarBCarConfigureModel_datalist *model = self.detailArray[index.row];
            [backShowString appendString:[NSString stringWithFormat:@"%@,",model.brightPackageName]];
            [backPageID appendString:[NSString stringWithFormat:@"%@,",model.id]];
        }
        if (index.section == 1) {
        UcarBCarConfigureModel_datalist *model = self.orderArray[index.row];
            [backShowString appendString:[NSString stringWithFormat:@"%@,",model.brightName]];
            [backID appendString:[NSString stringWithFormat:@"%@,",model.id]];
        }
    }
    [backShowString appendString:[NSString stringWithFormat:@"%@,",self.moreInfoTextView.text]];
    if (backShowString.length >= 1) {
        [backShowString deleteCharactersInRange:NSMakeRange(backShowString.length - 1, 1)];
    }
    NSString *blockStrName = [NSString stringWithFormat:@"%@",backShowString];
    self.blkData(blockStrName, backPageID, backID, self.moreInfoTextView.text);
    [self.navigationController popViewControllerAnimated:YES];
    } else {
      self.blkData(self.moreInfoTextView.text, nil, nil, self.moreInfoTextView.text);
     [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.goodsTemplateId == nil) {
//        UCarBCarSourceLocationViewController *diyViewController = [[UCarBCarSourceLocationViewController alloc] init];
//        diyViewController.tipString = @"";
//        diyViewController.placeString = @"请输入配置";
//        diyViewController.title = @"配置";
//        [self.navigationController pushViewController:diyViewController animated:YES];
    } else {
        if (indexPath.section == 0 || indexPath.section == 1) {
            NSString *chooseString = _chooseArray[indexPath.section][indexPath.row];
            if ([chooseString isEqualToString:@"0"]) {
                chooseString = @"1";
            } else {
                chooseString = @"0";
            }
            NSMutableArray *tempArr = _chooseArray[indexPath.section];
            [tempArr replaceObjectAtIndex:indexPath.row withObject:chooseString];
            [_chooseArray replaceObjectAtIndex:indexPath.section withObject:tempArr];
            
            [self.tableViewConfigure reloadData];
        } else {
////            * 配置自定义单独界面
//            UCarBCarSourceLocationViewController *diyViewController = [[UCarBCarSourceLocationViewController alloc] init];
//            diyViewController.tipString = @"";
//            diyViewController.placeString = @"请输入配置";
//            diyViewController.title = @"配置";
//            [self.navigationController pushViewController:diyViewController animated:YES];
//            if (indexPath.row == 0) {
//                
//            }
            
        }
    }
}

#pragma mark TableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.goodsTemplateId == nil) {
        return 2;
    }
    return [_dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.goodsTemplateId != nil) {
        if (indexPath.section == 2 && indexPath.row == 1) {
            return 80;
        }
        return 45;
    } else {
        if (indexPath.row == 0) {
            return 45;
        } else {
            return 80;
        }
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.goodsTemplateId != nil) {
        if (indexPath.section == 0) {
            UCarBCarConfigureDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseConfigDetail];
            cell.indexRow = indexPath.row;
            UcarBCarConfigureModel_datalist *model = self.detailArray[indexPath.row];
            cell.infoLabel.text = model.brightPackageName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.is_Use = _chooseArray[indexPath.section][indexPath.row];
            return cell;
        } else if (indexPath.section == 1) {
            UCarBCarConfigureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseConfigOrder];
            UcarBCarConfigureModel_datalist *model = self.orderArray[indexPath.row];
            cell.infoLabel.text = model.brightName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.is_Use = _chooseArray[indexPath.section][indexPath.row];
            return cell;
        } else {
            if (indexPath.row == 0) {
                UCarBOrderTypePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseDIY];
                cell.guidePrice.text = @"自定义配置";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            } else {
                UCarBInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseMoreInfo];
                cell.moreInfoLabel.text = @"请输入自定义配置";
                cell.inPutTextField.text = self.moreInfoTextView.text;
                self.moreInfoTextView = cell.inPutTextField;
                return cell;
            }
        }

    } else {
        if (indexPath.row == 0) {
            UCarBOrderTypePriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseDIY];
            cell.guidePrice.text = @"自定义配置";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            UCarBInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseMoreInfo];
            cell.moreInfoLabel.text = @"请输入自定义配置";
            cell.inPutTextField.text = self.moreInfoTextView.text;
            self.moreInfoTextView = cell.inPutTextField;
            return cell;
        }
       }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_dataSource[section] count] == 0) {
        return 0;
    } else {
    
    if (self.goodsTemplateId != nil) {
        if (section == 0 || section == 1) {
            return 25;
        } else {
            return 11;
        }
    } else {
        return 11;
    }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.goodsTemplateId != nil) {
        if (section == 0) {
            UCarBHeaderView *headerView = [UCarBHeaderView instanceView:@"选配"];
            return headerView;
        } else if (section == 1) {
            UCarBHeaderView *headerView = [UCarBHeaderView instanceView:@"配置"];
            return headerView;
        } else {
            UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
            return nilView;
        }
    } else {
        UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
        return nilView;
    }
}

#pragma mark Setter/Getter
- (UITableView *)tableViewConfigure
{
    if (_tableViewConfigure == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarConfigureDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseConfigDetail];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBCarConfigureTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseConfigOrder];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBOrderTypePriceTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseDIY];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBInputTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseMoreInfo];
        _tableViewConfigure = tempTableView;
    }
    return _tableViewConfigure;
}

- (void)StartLayoutTableView
{
    if (self.goodsTemplateId != nil) {
        self.dataSource = [NSArray arrayWithObjects:_detailArray,_orderArray,@[@"自定义配置",@"备注"], nil];
    }
    NSMutableArray *tempDetailArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.detailArray.count; i++) {
            NSString *temp = @"0";
            [tempDetailArray addObject:temp];
        }
    NSMutableArray *tempOrderArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.orderArray.count; i++) {
            NSString *temp = @"0";
            [tempOrderArray addObject:temp];
        }
        self.chooseArray = [NSMutableArray arrayWithObjects:tempDetailArray, tempOrderArray, nil];
    
       dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        [self.view addSubview:self.tableViewConfigure];
        [self configLayout];
    });
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
