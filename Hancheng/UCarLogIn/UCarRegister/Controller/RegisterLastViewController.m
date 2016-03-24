//
//  RegisterLastViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterLastViewController.h"
#import "UCarBOrderTypeTableViewCell.h"
#import "RegisterPhoneNumberTableViewCell.h"
#import "UCarShopBuyButtonView.h"
#import "UCarBCarSourceLocationViewController.h"
#import "UCarProvinceViewController.h"
#import "C_64Model+NetAction.h"
#import "CompanyViewController.h"
#import "ContacViewController.h"
#import "UCarUserLicenseViewController.h"
#import "UCarNameAndPhoneTableViewCell.h"
#import "UCarNameAndArrowTableViewCell.h"

static NSString *const reuseNamePhone = @"UCarNameAndPhoneTableViewCell";
static NSString *const reuseNameArrow = @"UCarNameAndArrowTableViewCell";

@interface RegisterLastViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewRegisterLastStep;
@property (nonatomic, strong) NSArray *dataSrouceTitle;
@property (nonatomic, strong) NSMutableArray *dataSourceInfoName;
@property (nonatomic, strong) C_64Model *model;

@end

@implementation RegisterLastViewController
{
    NSNumber *_cityID;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self handleNetData];
    self.title = @"认证";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToMain)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *successFull = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"认证成功"]];
    successFull.frame = CGRectMake(0, 0, 0, 0);
    successFull.center = CGPointMake(SCREENWIDTH / 2, 68);
    successFull.alpha = 0;
    [self.view addSubview:successFull];
    
    
    UILabel *congratulations = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, SCREENWIDTH, 0)];
    congratulations.textColor = HEXCOLOR(0x25ae5f);
    congratulations.font = Font(16);
    congratulations.textAlignment = NSTextAlignmentCenter;
    congratulations.text = @"恭喜您 ! 注册成功";
    congratulations.center = CGPointMake(SCREENWIDTH / 2, 128);
    congratulations.alpha = 0;
    [self.view addSubview:congratulations];
    
    UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, SCREENWIDTH, 0)];
    moreInfo.textColor = HEXCOLOR(0x999999);
    moreInfo.font  = Font(13);
    moreInfo.textAlignment = NSTextAlignmentCenter;
    moreInfo.center = CGPointMake(SCREENWIDTH / 2, 145);
    moreInfo.text = @"认证信息让买卖更直接";
    moreInfo.alpha = 0;
    [self.view addSubview:moreInfo];
    
    
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationDuration:1];
    successFull.alpha = 1;
    congratulations.alpha = 1;
    moreInfo.alpha = 1;
    congratulations.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
    congratulations.center = CGPointMake(SCREENWIDTH / 2, 128);
    moreInfo.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
    moreInfo.center = CGPointMake(SCREENWIDTH / 2, 145);
    successFull.frame = CGRectMake(0, 0, 88 * 270 / 249, 88 );
    successFull.center = CGPointMake(SCREENWIDTH / 2, 68);
    [UIView commitAnimations];
}


- (void)makeSureRegister
{
    // 提交注册
    if (self.model.photo.length > 1) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:CENTERLOGIN object:nil];
    } else {
        if ([self.model.role_id isEqualToString:@"1"] || [self.model.role_id isEqualToString:@"3"]) {
            [self showHint:@"您尚未上传身份证照片"];
        } else
        {
            [self showHint:@"您尚未上传营业执照"];
        }
    }
}

- (void)jumpToMain
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:CENTERLOGIN object:nil];
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        UCarBCarSourceLocationViewController *nameController = [[UCarBCarSourceLocationViewController alloc] initWithNibName:NSStringFromClass([UCarBCarSourceLocationViewController class]) bundle:nil];
        nameController.title = @"昵称";
        nameController.tipString = @"       您的昵称 \n";
        nameController.placeString = @"请输入昵称";
        
        [self.navigationController pushViewController:nameController animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        UCarProvinceViewController *provinceController = [[UCarProvinceViewController alloc] init];
        [self.navigationController pushViewController:provinceController animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([self.model.role_id isEqualToString:@"1"] || [self.model.role_id isEqualToString:@"3"]) {
            UCarUserLicenseViewController *licenseVC = [[UCarUserLicenseViewController alloc]init];
            licenseVC.isAuth = self.model.is_auth;
            licenseVC.role_id = self.model.role_id;
            licenseVC.licienceImageUrl = [NSString stringWithFormat:@"%@/%@",self.model.imageURL,self.model.photo];
            [self.navigationController pushViewController:licenseVC animated:YES];
            
        } else {
            CompanyViewController *companyVC = [[CompanyViewController alloc]init];
            companyVC.state = @"企业";
            companyVC.inputCompNameZeroRow = self.model.company_name;
            companyVC.inputAddressOneRow = self.model.address;
            [self.navigationController pushViewController:companyVC animated:YES];
        }
    }
    if (indexPath.section == 1 && indexPath.row ==1) {
        if ([self.model.role_id isEqualToString:@"1"] || [self.model.role_id isEqualToString:@"3"]) {
            CompanyViewController *companyVC = [[CompanyViewController alloc]init];
            companyVC.state = @"个人";
            companyVC.inputCompNameZeroRow = self.model.personal_company;
            companyVC.inputAddressOneRow = self.model.address;
            companyVC.inputMoreRowThree = self.model.personal_post;
            [self.navigationController pushViewController:companyVC animated:YES];
        } else {
            UCarUserLicenseViewController *licenseVC = [[UCarUserLicenseViewController alloc]init];
            licenseVC.isAuth = self.model.is_auth;
            licenseVC.role_id = self.model.role_id;
            licenseVC.licienceImageUrl = [NSString stringWithFormat:@"%@/%@",self.model.imageURL,self.model.photo];
            [self.navigationController pushViewController:licenseVC animated:YES];
        }
    }
    if (indexPath.section == 2) {
        ContacViewController *contacVC = [[ContacViewController alloc] initWithNibName:NSStringFromClass([ContacViewController class]) bundle:nil];
        contacVC.user_name = self.model.user_name;
        if (self.model.phone.length > 0) {
            NSArray *tempArray = [self.model.phone componentsSeparatedByString:@","];
            NSMutableArray *tempMutableArray = [NSMutableArray new];
            for (NSString *tempStr in tempArray) {
                [tempMutableArray addObject:tempStr];
            }
            contacVC.phoneNumberArray = tempMutableArray;
        } else {
            contacVC.phoneNumberArray = [NSMutableArray new];
        }
        [self.navigationController pushViewController:contacVC animated:YES];
        
    }

}

#pragma mark Network
- (void)handleNetData
{
    WS(weakSelf)
    [C_64Model handleWithSuccessBlock:^(id returnValue) {
        weakSelf.model = [C_64Model new];
        weakSelf.model = returnValue;
        if ([self.model.role_id isEqualToString:@"1"] || [self.model.role_id isEqualToString:@"3"]) {
            self.dataSrouceTitle = @[@[@"注册手机",@"昵称",@"城市"],@[@"身份证信息",@"所属公司信息"],@[@"联系方式"]];
        } else {
            self.dataSrouceTitle = @[@[@"注册手机",@"昵称",@"城市"],@[@"公司信息",@"营业执照"],@[@"联系方式"]];
        }
        dispatch_queue_t main = dispatch_get_main_queue();
        dispatch_async(main, ^{
            [self.view addSubview:self.tableViewRegisterLastStep];
            [weakSelf configLayout];
            [weakSelf.tableViewRegisterLastStep reloadData];
            [weakSelf saveUserInfo];
        });
    } WithFailureBlock:^(id error) {
        NSLog(@"请求失败");
    } WithUid:[UserMangerDefaults UidGet]];
}

#pragma mark Layout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableViewRegisterLastStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view).offset(159);
    }];
}

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSrouceTitle[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarNameAndPhoneTableViewCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:reuseNamePhone];
    UCarNameAndArrowTableViewCell *arrowCell = [tableView dequeueReusableCellWithIdentifier:reuseNameArrow];
    arrowCell.infoLabel.textColor = HEXCOLOR(0x333333);
    if (indexPath.section == 0 && indexPath.row == 0) {
        phoneCell.titleLabel.text = self.dataSrouceTitle[indexPath.section][indexPath.row];
        phoneCell.infoLabel.text = self.model.user_name;
        phoneCell.lineState = 1;
        phoneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return phoneCell;
    } else {
        arrowCell.titleLabel.text = self.dataSrouceTitle[indexPath.section][indexPath.row];
        
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                arrowCell.lineState = 3;
                arrowCell.infoLabel.text = self.model.nickName;
            }
            if (indexPath.row == 2) {
                arrowCell.lineState = 2;
                arrowCell.infoLabel.text = self.model.CityName;
            }
        } else
            
            if (indexPath.section == 1) {
                NSString *rowOne = @"";
                NSString *rowTwo = @"";
                if ([self.model.role_id isEqualToString:@"1"] || [self.model.role_id isEqualToString:@"3"]) {
                    rowOne =  [self.model.is_auth isEqualToString:@"1"] ? @"已认证" : @"未认证";
                    rowTwo = self.model.personal_company.length >= 1 ? @"已完善" : @"未完善";
                } else {
                    rowOne =  self.model.company_name.length >= 1 ? @"已完善" : @"未完善";
                    rowTwo = [self.model.is_auth isEqualToString:@"1"] ? @"已认证" : @"未认证";
                }
                if (indexPath.row == 0)  {
                    arrowCell.lineState = 1;
                    arrowCell.infoLabel.text = rowOne;
                    if ([rowOne isEqualToString:@"未认证"] || [rowOne isEqualToString:@"未完善"]) { arrowCell.infoLabel.textColor = HEXCOLOR(0xff5000);
                    } else { arrowCell.infoLabel.textColor = HEXCOLOR(0x25ae5f);}
                }
                if (indexPath.row == 1) {
                    arrowCell.lineState = 2;
                    arrowCell.infoLabel.text = rowTwo;
                    if ([rowTwo isEqualToString:@"未认证"] || [rowTwo isEqualToString:@"未完善"]) { arrowCell.infoLabel.textColor = HEXCOLOR(0xff5000);
                    } else { arrowCell.infoLabel.textColor = HEXCOLOR(0x25ae5f);}
                }
            } else
                
                if (indexPath.section == 2) {
                    arrowCell.lineState = 0;
                    arrowCell.infoLabel.text = @"";
                }
        return arrowCell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 80;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UCarShopBuyButtonView *footerView = [[[NSBundle mainBundle]loadNibNamed:@"UCarShopBuyButtonView" owner:nil options:nil] lastObject];
        [footerView.sendButton setTitle:@"确认注册" forState:UIControlStateNormal];
        [footerView.sendButton addTarget:self action:@selector(makeSureRegister) forControlEvents:UIControlEventTouchUpInside];
        return footerView;
    } else {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}

#pragma mark SET/GET

- (UITableView *)tableViewRegisterLastStep
{
    if (_tableViewRegisterLastStep == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.dataSource = self;
        tempTableView.delegate = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarNameAndPhoneTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseNamePhone];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarNameAndArrowTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseNameArrow];
        _tableViewRegisterLastStep = tempTableView;
    }
    return _tableViewRegisterLastStep;
}

- (void)saveUserInfo // 保存用户信息
{
    UCARNSUSERDEFULTS(userDefaults)
    if (self.model.phone) [userDefaults setObject:self.model.phone forKey:UCARPHONENUMBER]; // 联系方式
    if (self.model.role_id) [userDefaults setObject:self.model.role_id forKey:UCARROLE_ID];   // 角色
    if (self.model.is_auth) [userDefaults setObject:self.model.is_auth forKey:UCARIS_AUTH];   // 认证
    if (self.model.user_name) [userDefaults setObject:self.model.user_name forKey:UCARUSER_NAME]; //user_name手机号
}


- (NSArray *)dataSrouceTitle
{
    if (_dataSrouceTitle == nil) {
        NSArray *tempArray = [NSArray new];
        _dataSrouceTitle = tempArray;
    }
    return _dataSrouceTitle;
}

-(NSMutableArray *)dataSourceInfoName
{
    if (_dataSourceInfoName == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        _dataSourceInfoName = tempArray;
    }
    return _dataSourceInfoName;
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
