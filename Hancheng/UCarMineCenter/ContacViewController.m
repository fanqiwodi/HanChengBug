//
//  ContacViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ContacViewController.h"
#import "ContacChlidViewController.h"
#import "C_64Model.h"
#import "DeleteContactViewController.h"

#import "UCarNameAndPhoneTableViewCell.h"
#import "UCarNameAndArrowTableViewCell.h"
#import "UCarCellButtonTableViewCell.h"
static NSString *const reuseNameAndPhont = @"UCarNameAndPhoneTableViewCell";
static NSString *const reuseNameAndArrow = @"UCarNameAndArrowTableViewCell";
static NSString *const reuseAddCell      = @"UCarCellButtonTableViewCell";

@interface ContacViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableViewContact;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ContacViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"联系方式";
    self.dataSource = self.phoneNumberArray;
    [self.view addSubview:self.tableViewContact];
    [self configLayout];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataSource.count < 2) {
        return 2;
    } else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != 0) {
        return 1;
    } else
        return self.dataSource.count + 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarNameAndArrowTableViewCell *cellArrow = [tableView dequeueReusableCellWithIdentifier:reuseNameAndArrow];
    UCarNameAndPhoneTableViewCell *cellPhont = [tableView dequeueReusableCellWithIdentifier:reuseNameAndPhont];
 
    cellPhont.infoLabel.textColor = HEXCOLOR(0x239aec);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cellPhont.titleLabel.text = @"注册手机";
            cellPhont.infoLabel.text = self.user_name;
            cellPhont.lineState = 1;
            cellPhont.selectionStyle = UITableViewCellSelectionStyleNone;
            return cellPhont;
        } else {
            cellArrow.lineState = 2;
            cellArrow.titleLabel.text = [NSString stringWithFormat:@"联系方式%lu", indexPath.row];
            cellArrow.infoLabel.text = self.dataSource[indexPath.row - 1];
            return cellArrow;
        }
    }
    if (indexPath.section == 1) {
        UCarCellButtonTableViewCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:reuseAddCell];
        buttonCell.infoLabel.text = @"添加";
        return buttonCell;
       
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    } else {
        return 20;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        ContacChlidViewController *addPhoneVC = [[ContacChlidViewController alloc] init];
        addPhoneVC.phoneNumberArray = self.dataSource;
        addPhoneVC.is_add = ^(BOOL is_add, NSString *phoneNumber) {
            if (is_add) {
                [self.dataSource addObject:phoneNumber];
                [self.tableViewContact reloadData];
            }
        };
        [self.navigationController pushViewController:addPhoneVC animated:YES];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row != 0) {
            DeleteContactViewController *deleteVC = [[DeleteContactViewController alloc] initWithNibName:NSStringFromClass([DeleteContactViewController class]) bundle:nil];
            deleteVC.showNumber = self.dataSource[indexPath.row - 1];
            if (self.dataSource.count == 2) {
                if (indexPath.row == 1) {
                    deleteVC.phone = self.dataSource[1];
                } else {
                    deleteVC.phone = self.dataSource[0];
                }
            } else {
                deleteVC.phone = @"";
            }
            deleteVC.is_delete = ^(BOOL is_delete, NSString *phoneNumber){
                if (is_delete) {
                    [self.dataSource removeObjectAtIndex:(indexPath.row - 1)];
                    [self.tableViewContact reloadData];
                } else {
                    [self.dataSource replaceObjectAtIndex:(indexPath.row - 1) withObject:phoneNumber];
                    [self.tableViewContact reloadData];
                }
            };
            [self.navigationController pushViewController:deleteVC animated:YES];
        }
    }
}

#pragma mark LayoutSize
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewContact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

#pragma mark SET/GET

- (UITableView *)tableViewContact
{
    if (_tableViewContact == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarNameAndArrowTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseNameAndArrow];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarNameAndPhoneTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseNameAndPhont];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarCellButtonTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseAddCell];
        _tableViewContact = tempTableView;
    }
    return _tableViewContact;
}

- (NSMutableArray *)phoneNumberArray
{
    if (_phoneNumberArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _phoneNumberArray = tempArray;
    }
    return _phoneNumberArray;
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
