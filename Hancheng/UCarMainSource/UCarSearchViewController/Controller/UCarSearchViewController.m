//
//  UCarSearchViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarSearchViewController.h"
#import "UCarMainSourceNetwork.h"
#import "UCarTableViewSWCell.h"
#import "UCarPublishMainModel.h"
#import "UCarSearchCheckViewController.h"
#import <MJRefresh.h>
#import "UCarHaveSendViewController.h"
#import "BaseNavigationViewController.h"
static  NSString *const reuseCell = @"UCarTableViewSWCell";
@interface UCarSearchViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIView *unUserBackWhiteView;
@property (strong, nonatomic) IBOutlet UIButton *searchInfoButton;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIView *clearCheckStateView;
@property (strong, nonatomic) IBOutlet UIButton *clearCheckStateButton;
@property (strong, nonatomic) IBOutlet UILabel *clearCheckStateLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *clearCheckStateViewHeight;


/**< 搜索结果数组*/
@property (nonatomic, strong) UITableView *tableViewSearchView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableDictionary *paramDictory;
@property (nonatomic, strong) UCarSearchCheckViewController *searchViewController;

@end

@implementation UCarSearchViewController
{
    NSString *searchString;
    NSInteger _startNum;
    
    NSInteger pageNumber;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    pageNumber = 0;
    self.tableViewSearchView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configNetwork)];
    self.tableViewSearchView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(configFooter)];
}

- (void)configFooter
{
    pageNumber++;
    [self.paramDictory setValue:self.searchTextField.text forKey:@"keyWord"];
    NSMutableDictionary *tempDict = [self.paramDictory mutableCopy];
    [tempDict setValue:@20 forKey:@"pageSize"];
    [tempDict setValue:[NSString stringWithFormat:@"%ld",pageNumber] forKey:@"startNum"];
    [UCarMainSourceNetwork GETWithA88:^(id returnValue) {
        NSArray *tempArray = returnValue;
        [self.dataSource addObjectsFromArray:tempArray];
        if (self.dataSource.count > 0) {
            self.searchInfoButton.alpha = 1;
        } else {
            self.searchInfoButton.alpha = 0;
            [self.tableViewSearchView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.view addSubview:self.tableViewSearchView];
        [self configLayout];
        [self.tableViewSearchView reloadData];
        [self.tableViewSearchView.mj_footer endRefreshing];
        [self.view bringSubviewToFront:self.searchInfoButton];
    } FailureBlk:^(id error) {
        
    } param:tempDict];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _startNum = 0;
    // Do any additional setup after loading the view from its nib.
    self.searchTextField.delegate = self;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.clearCheckStateViewHeight.constant = 0;
    self.clearCheckStateView.alpha = 0;
    self.searchInfoButton.alpha = 0;
    self.clearCheckStateButton.layer.borderColor = HEXCOLOR(0x33a1ed).CGColor;
    self.clearCheckStateButton.layer.borderWidth = 1;
    self.clearCheckStateButton.layer.cornerRadius = 14;
    self.clearCheckStateButton.layer.masksToBounds = YES;
    self.unUserBackWhiteView.layer.cornerRadius = 16;
    self.unUserBackWhiteView.layer.masksToBounds = YES;
    self.searchTextField.placeholder = @"可输入车型、颜色、价格、配置...";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.searchTextField becomeFirstResponder];
    
    WS(weakSelf)
    self.searchViewController.blockParams = ^(NSMutableDictionary *params, NSMutableArray *nameArray) {
        weakSelf.paramDictory = params;
        NSMutableString *terms = [NSMutableString stringWithString:@""];
        for (NSString *title in nameArray) {
            if ([title isEqualToString:@"全部"] || [title isEqualToString:@"不限"]) {
                
            } else {
                [terms appendString:[NSString stringWithFormat:@" | %@",title]];
            }
        }
        if (terms.length < 1) {
            [terms appendString:@"全部"];
        }
        weakSelf.clearCheckStateLabel.text = [NSString stringWithFormat:@"筛选条件:%@",terms];
        weakSelf.clearCheckStateView.alpha = 1;
        weakSelf.clearCheckStateViewHeight.constant = 44;
        [weakSelf configNetwork];
    };
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarPublishMainModel_data_bodys *model = [self.dataSource objectAtIndex:indexPath.section];
    UCarHaveSendViewController *detailVC = [[UCarHaveSendViewController alloc] init];
    BaseNavigationViewController *rootVC = [[BaseNavigationViewController alloc] initWithRootViewController:detailVC];
    detailVC.carID = model.id;
    detailVC.pageState = PageFromStateFromWhy;
    detailVC.dismissState = 1;
    [self presentViewController:rootVC animated:YES completion:nil];
}

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarTableViewSWCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    cell.pageType = 1;
    UCarPublishMainModel_data_bodys *model = [self.dataSource objectAtIndex:indexPath.section];
    cell.model = model;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


#pragma mark ButtonAction
- (IBAction)backButtonAction:(id)sender {
    [self.searchTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)searchButtonAction:(id)sender {
    [self.searchTextField resignFirstResponder];
    if (!searchString) {
        searchString = self.searchTextField.text;
    } else {
        if (![searchString isEqualToString:self.searchTextField.text]) {
            [self.searchViewController setClearAction];
            self.clearCheckStateViewHeight.constant = 0;
            self.clearCheckStateView.alpha = 0;
        }
    }
    [self configNetwork];
}
- (IBAction)searchTextFieldBeganEdit:(id)sender {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)searchInfoButtonAction:(id)sender {
    [self.searchTextField resignFirstResponder];
    self.searchViewController.keyWord = self.searchTextField.text;
    self.searchViewController.params = self.paramDictory;
    [self presentViewController:self.searchViewController animated:YES completion:nil];
}
- (IBAction)clearCheckStateButtonAction:(id)sender {
    self.clearCheckStateViewHeight.constant = 0;
    self.clearCheckStateView.alpha = 0;
    self.paramDictory = [NSMutableDictionary new];
    [self.searchViewController setClearAction];
    [self configNetwork];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self performSelectorOnMainThread:@selector(searchButtonAction:) withObject:nil waitUntilDone:NO];
    return YES;
}

- (void)configNetwork
{
    [self.paramDictory setValue:self.searchTextField.text forKey:@"keyWord"];
    NSMutableDictionary *tempDict = [self.paramDictory mutableCopy];
    [tempDict setValue:@20 forKey:@"pageSize"];
    [tempDict setValue:@0 forKey:@"startNum"];
    [UCarMainSourceNetwork GETWithA88:^(id returnValue) {
        self.dataSource = [returnValue mutableCopy];
        if (self.dataSource.count > 0) {
            self.searchInfoButton.alpha = 1;
        } else {
            self.searchInfoButton.alpha = 0;
        }
        [self.view addSubview:self.tableViewSearchView];
        [self configLayout];
        [self.tableViewSearchView reloadData];
        [self.tableViewSearchView.mj_header endRefreshing];
        [self.view bringSubviewToFront:self.searchInfoButton];
    } FailureBlk:^(id error) {
        
    } param:tempDict];
}

- (void)getNextPage
{
    _startNum++;
    [self.paramDictory setValue:self.searchTextField.text forKey:@"keyWord"];
    NSMutableDictionary *tempDict = [self.paramDictory mutableCopy];
    NSNumber *page = [NSNumber numberWithInteger:_startNum];
    [tempDict setValue:@20 forKey:@"pageSize"];
    [tempDict setValue:page forKey:@"startNum"];
    [UCarMainSourceNetwork GETWithA88:^(id returnValue) {
        self.dataSource = returnValue;
        if (self.dataSource.count > 0) {
            self.searchInfoButton.alpha = 1;
        } else {
            self.searchInfoButton.alpha = 0;
        }
        [self.view addSubview:self.tableViewSearchView];
        [self configLayout];
        [self.tableViewSearchView reloadData];
        [self.view bringSubviewToFront:self.searchInfoButton];
    } FailureBlk:^(id error) {
        
    } param:tempDict];

}

#pragma mark ConfigLayou
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.clearCheckStateView.mas_bottom);
    }];
}

#pragma mark SET/GET
- (UITableView *)tableViewSearchView
{
    if (_tableViewSearchView == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarTableViewSWCell class]) bundle:nil] forCellReuseIdentifier:reuseCell];
        _tableViewSearchView = tempTableView;
    }
    return _tableViewSearchView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        NSArray *tempMutableArray = [NSArray new];
        _dataSource = tempMutableArray;
    }
    return _dataSource;
}

-(NSMutableDictionary *)paramDictory
{
    if (_paramDictory == nil) {
        NSMutableDictionary *tempDictory = [NSMutableDictionary new];
        _paramDictory = tempDictory;
    }
    return _paramDictory;
}

- (UCarSearchCheckViewController *)searchViewController
{
    if (_searchViewController == nil) {
        UCarSearchCheckViewController *tempSearchView = [[UCarSearchCheckViewController alloc] initWithNibName:NSStringFromClass([UCarSearchCheckViewController class]) bundle:nil];
        _searchViewController = tempSearchView;
    }
    return _searchViewController;
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
