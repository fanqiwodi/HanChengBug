//
//  VIPViewController.m
//  Hancheng
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//
#import "LGAlertView.h"
#import "C_58_infoModel.h"
#import "VIPViewController.h"
#import "VIPSectio0TableViewCell.h"
#import "VIPSection1TableViewCell.h"
#import "VIPSection2TableViewCell.h"
#import "VIPSection3TableViewCell.h"
@interface VIPViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *dataDic;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation VIPViewController

- (void)initTableView
{
    NSArray *rowArr = @[@{@"text":@"U特价\n游览所有特价车源信息", @"img":@"uck_pcenter_pat_uck_sales"}, @{@"text":@"U选车\n优先推荐优质车源、提供免\n费、专业的验车服务", @"img": @"uck_pcenter_pat_uck_select_car"}];
    NSArray *rowArr1 = @[@{@"text":@"U金融\n会员可申请垫付款发车服务，审\n核通过过，享受利率0.5/天", @"img":@"uck_pcenter_pat_uck_finance"}, @{@"text":@"U客服\n享受您的专属服务，销售环节\n全程跟踪，物流信息及时反馈", @"img":@"uck_pcenter_pat_uck_customer_service"}];
    NSArray *rowArr2 = @[@{@"text":@"U车位\n为您提供展示'车位'优先推送，\n促成销售",@"img":@"uck_pcenter_pat_u_park_place"}, @{@"text":@"U积分\n累计积分，提升等级，享受\n汽车金融，延保，商城折扣", @"img": @"uck_pcenter_pat_uck_score"}];
    
   UCARNSUSERDEFULTS(userDefaults)
    
    dataDic = @{@"0":@[@{@"lock":@"uck_pcenter_icon_not_vip", @"unlock":@"uck_pcenter_icon_is_vip"}, [userDefaults objectForKey:UCARIS_PAY]], @"2":@[rowArr, rowArr1, rowArr2], @"1":@[@""], @"3":@[@"icon_all_brand"]};
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView registerNib:[UINib nibWithNibName:@"VIPSectio0TableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([VIPSectio0TableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:@"VIPSection1TableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([VIPSection1TableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:@"VIPSection2TableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([VIPSection2TableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:@"VIPSection3TableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([VIPSection3TableViewCell class])];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *secKey = [NSString stringWithFormat:@"%lu", indexPath.section];
    switch (indexPath.section) {
        case 0:
        {
            VIPSectio0TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VIPSectio0TableViewCell class]) forIndexPath:indexPath];
            [cell setArr: dataDic[secKey]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            VIPSection1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VIPSection1TableViewCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            VIPSection2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VIPSection2TableViewCell class]) forIndexPath:indexPath];
            [cell setArr:dataDic[secKey][indexPath.row]];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        case 3:
        {
            VIPSection3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VIPSection3TableViewCell class]) forIndexPath:indexPath];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [[dataDic allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != 0) {
        NSString *secKey = [NSString stringWithFormat:@"%lu", section];
        NSArray *tempArr = dataDic[secKey];
        return tempArr.count;
    }
    return 1;
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
            return 250;
            break;
        case 1:
            return 55;
            break;
        case 2:
            return 140;
            break;
        case 3:
            return 80;
            break;
        default:
            break;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
//        UCARNSUSERDEFULTS(userDefaults)
//        if (![[userDefaults objectForKey:UCARIS_PAY]isEqualToNumber:@1]) {
            LGAlertView *alt  = [[LGAlertView alloc]initWithTitle:@"拨打电话" message:@"您确定要拨打电话：400-030-8181" style:0 buttonTitles:@[@"确定"]cancelButtonTitle:@"取消" destructiveButtonTitle:nil];
            alt.buttonsBackgroundColorHighlighted = [UIColor colorWithHexString:@"ff5000"];
            alt.buttonsTitleColor = [UIColor colorWithHexString:@"ff5000"];
            alt.cancelButtonTitleColor = [UIColor colorWithHexString:@"999999"];
            [alt showAnimated:YES completionHandler:^{
                
            }];
            alt.actionHandler = ^(LGAlertView *alertView, NSString *title, NSUInteger index){
                
                if (index==0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"tel://4000308181" ]];
                }
            };
            
//        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"会员服务";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

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
