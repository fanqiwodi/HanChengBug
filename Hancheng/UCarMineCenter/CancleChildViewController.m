//
//  CancleChildViewController.m
//  Hancheng
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CancleChildViewController.h"
#import "C_84Model.h"
@interface CancleChildViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (nonatomic, strong)NSArray *dataArr;
@end

@implementation CancleChildViewController

- (void)initView
{
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    [self.myTableview setTableFooterView:[UIView new]];
    [self.myTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)getNetData
{
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:@"/api/ucarshow/delList" header:nil];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        self.dataArr = [NSArray modelArrayWithClass:[C_84Model class] json:request.responseBody[@"datalist"]];
        [self.myTableview reloadData];
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    C_84Model *model86 = self.dataArr[indexPath.row];
    cell.textLabel.text = model86.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C_84Model *model86 = self.dataArr[indexPath.row];
    [[RootInstance shareRootInstance].rootDic setObject:model86.name forKey:@"取消理由"];
    [RootInstance shareRootInstance].mutableValue = [NSString stringWithFormat:@"%@", model86.valueId];

    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self getNetData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

SettingBottomBar

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
