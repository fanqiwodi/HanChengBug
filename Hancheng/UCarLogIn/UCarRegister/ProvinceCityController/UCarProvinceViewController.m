//
//  UCarProvinceViewController.m
//  Hancheng
//
//  Created by Tony on 16/2/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarProvinceViewController.h"
#import "RegisterUCarUserInfo.h"
#import "UCarCityViewController.h"

@interface UCarProvinceViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation UCarProvinceViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"选择省份";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseCell"];
    [self configNetwork];
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NetWork
- (void)configNetwork
{
    [RegisterUCarUserInfo GetChooseProvincesuccess:^(id returnValue) {
        self.dataSource = [returnValue mutableCopy];
        self.tableView.separatorColor = HEXCOLOR(0xe6e8eb);
        [self.tableView reloadData];
    } faliureBlk:^(id error) {
        NSLog(@"error @ UCarProvinceViewController");
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell" forIndexPath:indexPath];
    NSDictionary *tempDic = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.textColor = HEXCOLOR(0x666666);
    cell.textLabel.font = Font(15);
    cell.textLabel.text = [tempDic objectForKey:@"name"];
    
    if (indexPath.row >= 4) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *tempDic = [[self.dataSource objectAtIndex:indexPath.row] mutableCopy];
    NSNumber *provinceId = [tempDic objectForKey:@"id"];
    if (indexPath.row >= 4) {
        UCarCityViewController *cityController = [[UCarCityViewController alloc] init];
        cityController.ProvinceID = provinceId;
    [self.navigationController pushViewController:cityController animated:YES];
    } else {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:CENTERCITYNAME object:nil userInfo:tempDic];
        [self Network:provinceId];
    }
}

- (void)Network:(NSNumber *)provinceID
{
    PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc]initWith:@{@"provinceId":provinceID, @"cityId":provinceID} urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [self showHint:request.responseBody[@"msg"] yOffset:-400*REM];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(YTKBaseRequest *request) {
        
    }];
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
