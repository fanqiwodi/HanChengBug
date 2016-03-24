//
//  UCarCityViewController.m
//  Hancheng
//
//  Created by Tony on 16/2/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarCityViewController.h"
#import "RegisterUCarUserInfo.h"
#import "RegisterLastViewController.h"

@interface UCarCityViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewCity;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation UCarCityViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = @"选择市";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetwork];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    cell.textLabel.font = Font(15);
    cell.textLabel.textColor = HEXCOLOR(0x666666);
    NSDictionary *tempdic = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [tempdic objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSDictionary *tempDic = [self.dataSource objectAtIndex:indexPath.row];
    [center postNotificationName:CENTERCITYNAME object:self.ProvinceID userInfo:tempDic];
    
    [self Networkcity:[tempDic objectForKey:@"id"]];
}

- (void)Networkcity:(NSNumber *)cityID
{
    PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc]initWith:@{@"provinceId":self.ProvinceID, @"cityId":cityID} urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self showHint:request.responseBody[@"msg"] yOffset:-400*REM];
            NSInteger count =  self.navigationController.viewControllers.count;
            [self.navigationController popToViewController:self.navigationController.viewControllers[count - 3] animated:YES];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}



#pragma mark NetWork
- (void)configNetwork
{
    WS(weakSelf)
    [RegisterUCarUserInfo GetChooseCityProvinceID:self.ProvinceID success:^(id returnValue) {
        weakSelf.dataSource = returnValue;
        [weakSelf.view addSubview:weakSelf.tableViewCity];
        [weakSelf configLayout];
    } failureBlk:^(id error) {
        NSLog(@"error UCarCityViewController");
    }];
}

#pragma mark ConfigLayout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SET/GET
-(UITableView *)tableViewCity
{
    if (_tableViewCity == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorColor = HEXCOLOR(0xe6e8eb);
        [tempTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseCell"];
        _tableViewCity = tempTableView;
    }
    return _tableViewCity;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        NSArray *tempArray = [NSArray new];
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
