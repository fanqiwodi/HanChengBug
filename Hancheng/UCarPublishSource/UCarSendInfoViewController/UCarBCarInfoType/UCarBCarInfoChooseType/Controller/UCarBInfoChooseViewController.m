//
//  UCarBInfoChooseViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBInfoChooseViewController.h"
#import "UCarBHeaderView.h"

#import "UCarBCarInfoChooseTypeModel+UCarBCarInfoChooseTypeModel.h" /**< Model */
#import "UCarBInfoChooseTableViewCell.h"



static NSString *const reuseCarBInfoChoose = @"UCarBInfoChooseTableViewCell";
@interface UCarBInfoChooseViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableViewChooseInfo;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation UCarBInfoChooseViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"选择品牌";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetWork];
    self.refreash(0);
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBCarInfoChooseTypeModel_datalist *dataListModel = _dataSource[indexPath.section];
    UCarBCarInfoChooseTypeModel_datalist_value *model_value = dataListModel.value[indexPath.row];
    
    NSNumber *isUse = [[NSNumber alloc] initWithInteger:1];
    NSNumber *unIsUse = [[NSNumber alloc] initWithInteger:0];

#pragma mark 增加删除常用
    if ([model_value.isUse isEqualToNumber:isUse]) {
        
        NSDictionary *params = @{@"brandId":model_value.brandId};
        NSNumber *wrong = [[NSNumber alloc] initWithInteger:0];
        DeleteWithHeaderAPI *api = [[DeleteWithHeaderAPI alloc] initDeleteWith:params header:@{@"Uid":[UserMangerDefaults UidGet]} urlStr:B55DELETECOMMONTYPE];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            BaseModel *model = [BaseModel modelWithJSON:request.responseBody];
                NSLog(@"++%@",model);
            if ([model.code isEqualToNumber:wrong]) {
                model_value.isUse = unIsUse;
                [self showHint:@"取消成功"];
            } else {
                [self showHint:@"取消失败"];
            }
            [self.tableViewChooseInfo reloadData];
        } failure:^(YTKBaseRequest *request) {
                [self showHint:@"取消失败"];
                model_value.isUse = isUse;
        }];
        // 删除
    } else {
        NSDictionary *params = @{@"brandId":model_value.brandId};
        NSNumber *right = [[NSNumber alloc] initWithInteger:0];
        PostWithHeaderAPI *api = [[PostWithHeaderAPI alloc] initWith:params urlStr:B54ADDCOMMONTYPE header:@{@"Uid":[UserMangerDefaults UidGet]}];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            BaseModel *model = [BaseModel modelWithJSON:request.responseBody];
            if ([model.code isEqualToNumber:right]) {
                model_value.isUse = isUse;
                [self showHint:@"添加成功"];
            } else {
                [self showHint:@"添加失败"];
            }
            [self.tableViewChooseInfo reloadData];
        } failure:^(YTKBaseRequest *request) {
            [self showHint:@"添加失败"];
            model_value.isUse = unIsUse;
        }];
    }
    
    [self.tableViewChooseInfo reloadData];
}




#pragma mark TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UCarBCarInfoChooseTypeModel_datalist *model = _dataSource[section];
    return model.value.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarBInfoChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCarBInfoChoose forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UCarBCarInfoChooseTypeModel_datalist *dataListModel = _dataSource[indexPath.section];
    UCarBCarInfoChooseTypeModel_datalist_value *model_value = dataListModel.value[indexPath.row];
    cell.model = model_value;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UCarBCarInfoChooseTypeModel_datalist *modelDataList = _dataSource[section];
    UCarBHeaderView *headerView = [UCarBHeaderView instanceView:modelDataList.name];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

#pragma mark ConfigNetWork
- (void)configNetWork
{
    NSString *tempcarSourceCategoryId = [NSString stringWithFormat:@"%@",self.carSourceCategoryId];
    [UCarBCarInfoChooseTypeModel GETCommonCarTypeChoose:^(id returnValue) {
        self.dataSource = returnValue;
        [self.view addSubview:self.tableViewChooseInfo];
        [self configLayout];
    } Failure:^(id error) {
        
    } Header:[UserMangerDefaults UidGet] carSourceCategoryId:tempcarSourceCategoryId];
}

#pragma mark AutoLayout
- (void)configLayout
{
   WS(weakSelf)
    [weakSelf.tableViewChooseInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark SET/GET
- (UITableView *)tableViewChooseInfo
{
    if (_tableViewChooseInfo == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarBInfoChooseTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseCarBInfoChoose];
        _tableViewChooseInfo = tempTableView;
    }
    return _tableViewChooseInfo;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.refreash(1);
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
