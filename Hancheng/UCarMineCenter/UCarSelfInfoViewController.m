//
//  UCarSelfInfoViewController.m
//  Hancheng
//
//  Created by Tony on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarSelfInfoViewController.h"
#import "C_64Model+NetAction.h"
#import "UCarNameAndPhoneTableViewCell.h"
#import "UCarNameAndArrowTableViewCell.h"
#import "UCarBCarColorDIYViewController.h"
#import "UCarProvinceViewController.h"
// laowang
#import "CompanyViewController.h"
#import "ContacViewController.h"


#import "UCarUserLicenseViewController.h"
static NSString *const reuseNamePhone = @"UCarNameAndPhoneTableViewCell";
static NSString *const reuseNameArrow = @"UCarNameAndArrowTableViewCell";

@interface UCarSelfInfoViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableviewMineSelf;
@property (nonatomic, strong) NSArray *dataSrouceTitle;
@property (nonatomic, strong) NSMutableArray *dataSourceInfoName;
@property (nonatomic, strong) C_64Model *model;


@end

@implementation UCarSelfInfoViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    [self handleNetData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人资料";
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
            [self.view addSubview:self.tableviewMineSelf];
            [weakSelf configLayout];
            [weakSelf.tableviewMineSelf reloadData];
            [weakSelf saveUserInfo];
        });
    } WithFailureBlock:^(id error) {
        NSLog(@"请求失败");
    } WithUid:[UserMangerDefaults UidGet]];
}

- (void)saveUserInfo // 保存用户信息
{
    UCARNSUSERDEFULTS(userDefaults)
    if (self.model.phone) [userDefaults setObject:self.model.phone forKey:UCARPHONENUMBER]; // 联系方式
    if (self.model.role_id) [userDefaults setObject:self.model.role_id forKey:UCARROLE_ID];   // 角色
    if (self.model.is_auth) [userDefaults setObject:self.model.is_auth forKey:UCARIS_AUTH];   // 认证
    if (self.model.user_name) [userDefaults setObject:self.model.user_name forKey:UCARUSER_NAME]; //user_name手机号
}
#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        UCarBCarColorDIYViewController *inputNameVC = [[UCarBCarColorDIYViewController alloc] initWithNibName:NSStringFromClass([UCarBCarColorDIYViewController class]) bundle:nil];
        inputNameVC.viewState = 2;
        inputNameVC.inputName = self.model.nickName;
        [self.navigationController pushViewController:inputNameVC animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        UCarProvinceViewController *provinceController = [[UCarProvinceViewController alloc] init];
        [self.navigationController pushViewController:provinceController animated:YES];
        
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([self.model.role_id isEqualToString:@"1"] || [self.model.role_id isEqualToString:@"3"]) {
            UCarUserLicenseViewController *next = [[UCarUserLicenseViewController alloc] initWithNibName:NSStringFromClass([UCarUserLicenseViewController class]) bundle:nil];
            next.isAuth = self.model.is_auth;
            next.licienceImageUrl = [NSString stringWithFormat:@"%@/%@",self.model.imageURL,self.model.photo];
            next.role_id = self.model.role_id;
            [self.navigationController pushViewController:next animated:YES];

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
    return self.dataSrouceTitle.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 32;
    } else {
        return 12;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [UIView new];
        view.backgroundColor = BACKGROUNDCOLOR;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"   U车库会对商家信息进行审核，请确保信息的真实有效"];
            text.color = [UIColor grayColor];
            NSMutableAttributedString *attachment = nil;
            UIImage *img = [UIImage imageNamed:@"ico_tishi"];
            attachment = [NSMutableAttributedString attachmentStringWithContent:img contentMode:UIViewContentModeCenter attachmentSize:img.size alignToFont:[UIFont systemFontOfSize:12] alignment:YYTextVerticalAlignmentCenter];
            [text insertAttributedString:attachment atIndex:0];
            YYLabel *label = [YYLabel new];
            
            label.attributedText = text;
            label.backgroundColor = BACKGROUNDCOLOR;
            CGSize size = CGSizeMake(CGFLOAT_MAX, 32);
            YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
            
            dispatch_async_on_main_queue(^{
                label.size = layout.textBoundingSize;
                label.textLayout = layout;
                label.origin = CGPointMake(15, 8);
                [view addSubview:label];
            });
        });
        
        return view;
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark Layout
- (void)configLayout
{
    WS(weakSelf)
    [weakSelf.tableviewMineSelf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.mas_equalTo(weakSelf.view);
    }];
}

#pragma mark SET/GET
- (UITableView *)tableviewMineSelf
{
    if (_tableviewMineSelf == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.dataSource = self;
        tempTableView.delegate = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempTableView.backgroundColor = BACKGROUNDCOLOR;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarNameAndPhoneTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseNamePhone];
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarNameAndArrowTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseNameArrow];
        _tableviewMineSelf = tempTableView;
    }
    return _tableviewMineSelf;
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
