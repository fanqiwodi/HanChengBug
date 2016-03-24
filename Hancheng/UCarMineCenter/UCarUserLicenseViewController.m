//
//  UCarUserLicenseViewController.m
//  Hancheng
//
//  Created by Tony on 16/2/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarUserLicenseViewController.h"
#import "UploadViewController.h"
#import "C_58_infoModel.h"
#import "C_64Model+NetAction.h"
#import "WebViewController.h"
@interface UCarUserLicenseViewController () <UIAlertViewDelegate>

@property (nonatomic, assign) BOOL is_choose;
@property (nonatomic, strong) C_64Model *model;

@end

@implementation UCarUserLicenseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    UCARNSUSERDEFULTS(userDefaults)
    self.role_id = [userDefaults objectForKey:UCARROLE_ID];
    
    [self setHeaderCertification]; // 设置Title
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.registerNowButton.layer.cornerRadius = 20;
    self.registerNowButton.layer.masksToBounds = YES;
    self.is_choose = NO;
    
}

#pragma mark AlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.message isEqualToString:@"您的信息已提交，工作人员会在24小时之内尽快审核，请耐心等待!"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 设置Title 和 首行文字
- (void)setHeaderCertification
{
    
    if ([self.role_id isEqualToString:@"1"] || [self.role_id isEqualToString:@"3"]) {
        self.title = @"身份证信息";
    } else {
        self.title = @"企业营业执照信息";
    }
    NSLog(@"55");
    [self setViewShow:0];
    [C_64Model handleWithSuccessBlock:^(id returnValue) {
        self.model = [C_64Model new];
        [self setViewShow:1];
        self.model = returnValue;
        self.licienceImageUrl = [NSString stringWithFormat:@"%@/%@",self.model.imageURL,self.model.photo];
        NSLog(@"63 %@",self.model.is_auth);
        if ([self.model.is_auth isEqualToString:@"1"]) {
            [self showHavePassIdentify];
            NSLog(@"66 %@", self.role_id);
            if ([self.role_id isEqualToString:@"1"] || [self.role_id isEqualToString:@"3"]) {
                self.UCarCertificationLabel.text = @"您已通过身份认证";
            } else {
                self.UCarCertificationLabel.text = @"您已通过企业认证";
            }
        }  else {
            [self showHaveNotPassIdentify];
            if ([self.role_id isEqualToString:@"1"] || [self.role_id isEqualToString:@"3"]) {
                self.UCarCertificationLabel.text = @"实名认证, 让买卖车更直接!";
            } else {
                self.UCarCertificationLabel.text = @"企业认证, 让买卖车更直接!";
            }
        }
    } WithFailureBlock:^(id error) {
        NSLog(@"请求失败");
    } WithUid:[UserMangerDefaults UidGet]];
}

- (IBAction)agreementSelected:(id)sender {
    WebViewController *web = [[WebViewController alloc] init];
    web.identify = @"about";
    [self.navigationController pushViewController:web animated:YES];
    
}
- (IBAction)registerButtonAction:(id)sender {
    [self resignFirstResponder];
    
    NSLog(@"91");
    UploadViewController *uploadVC = [[UploadViewController alloc] init];
    if ([self.title isEqualToString: @"企业营业执照信息"]) {
        uploadVC.title = @"企业认证";
    } else {
        uploadVC.title = @"身份认证";
    }
    uploadVC.photoURL = self.licienceImageUrl;
    if (self.is_choose) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"U车库提示" message:@"请同意并勾选\n《U车库认证服务协议》" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    } else {
        WS(weakSelf)
        if (self.licienceImageUrl.length > 40) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"U车库提示" message:@"您的信息已提交，工作人员会在24小时之内尽快审核，请耐心等待!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        } else {
            
            if ([self.role_id isEqualToString:@"1"] || [self.role_id isEqualToString:@"3"]) {
                NSString *tempString = self.model.personal_identifier;
                if (self.identiflyTextField.text.length > 2) {
                    tempString = self.identiflyTextField.text;
                }
                PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc]initWith:@{@"real_name":self.realNameTextField.text, @"personal_identifier":tempString} urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
                [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                    [weakSelf showHint:request.responseBody[@"msg"] yOffset:-400*REM];
                    [weakSelf.navigationController pushViewController:uploadVC animated:YES];
                } failure:^(YTKBaseRequest *request) {
                }];
            } else {
                    [weakSelf.navigationController pushViewController:uploadVC animated:YES];
            }
        }
    }
}

- (void)showHavePassIdentify // 已经通过
{
    NSLog(@"126");
    if ([self.role_id isEqualToString:@"1"] || [self.role_id isEqualToString:@"3"]) {
        self.lastView.alpha = 0;
        self.realNameTextField.userInteractionEnabled = NO;
        self.identiflyTextField.userInteractionEnabled = NO;
        self.UCarCertificationImageView.image = [UIImage imageNamed:@"uck_pcenter_icon_id_card_identified"];
        self.UCarCertificationLabel.text = @"您已通过个人认证";
        self.realNameTextField.text = self.model.real_name;
        NSString *topChar = [self.model.personal_identifier substringWithRange:NSMakeRange(0, 1)];
        NSString *lastChar = [self.model.personal_identifier substringFromIndex:self.model.personal_identifier.length - 1];
        NSMutableString  *strInside = [NSMutableString new];
        for (NSInteger i = 0; i < self.model.personal_identifier.length - 2; i++) {
            [strInside appendString:@"*"];
        }
        self.identiflyTextField.text = [NSString stringWithFormat:@"%@%@%@",topChar,strInside,lastChar];
    } else {
        self.infoViewHeight.constant = 41;
        self.thirdView.alpha = 0;
        self.lastView.alpha = 0;
        self.identifiyNumberLabel.alpha = 0;
        self.UCarCertificationImageView.image = [UIImage imageNamed:@"uck_pcenter_icon_com_info_identified"];
        self.UCarCertificationLabel.text = @"您已通过企业认证";
        self.realNameLabel.text = @"企业认证";
        self.realNameTextField.userInteractionEnabled = NO;
        self.realNameTextField.text = @"已认证";
        self.realNameTextField.textColor = HEXCOLOR(0x25ae5f);
    }
}
- (void)showHaveNotPassIdentify // 尚未通过
{
        NSLog(@"156");
    if ([self.role_id isEqualToString:@"1"] || [self.role_id isEqualToString:@"3"]) {
        self.thirdView.alpha = 0;
        self.UCarCertificationImageView.image = [UIImage imageNamed:@"uck_pcenter_icon_id_card_none_identified"];
        self.UCarCertificationLabel.text = @"实名认证, 让买卖车更直接!";
        self.realNameTextField.text = self.model.real_name;
        
        if (self.model.personal_identifier.length > 2) {
            
            NSString *topChar = [self.model.personal_identifier substringWithRange:NSMakeRange(0, 1)];
            NSString *lastChar = [self.model.personal_identifier substringFromIndex:self.model.personal_identifier.length - 1];
            NSMutableString  *strInside = [NSMutableString new];
            for (NSInteger i = 0; i < self.model.personal_identifier.length - 2; i++) {
                [strInside appendString:@"*"];
            }
            
            self.identiflyTextField.placeholder = [NSString stringWithFormat:@"%@%@%@",topChar,strInside,lastChar];
        }
    } else {
        self.firstView.alpha = 0;
        self.infoViewHeight.constant = 0;
        self.thirdView.alpha = 0;
        self.UCarCertificationImageView.image = [UIImage imageNamed:@"uck_pcenter_icon_com_info_none_identified"];
        self.UCarCertificationLabel.text = @"企业认证, 让买卖车更直接!";
    }
}

- (void)setViewShow:(NSInteger)show
{
    self.firstView.alpha = self.thirdView.alpha = self.lastView.alpha = show;
}

// 选择同意前面圆圈
- (IBAction)is_chooseAgreement:(id)sender {
    if (self.is_choose) {
        [self.dotButton setBackgroundImage:[UIImage imageNamed:@"成为U车库车源商提示对勾"] forState:UIControlStateNormal];
    } else {
        [self.dotButton setBackgroundImage:[UIImage imageNamed:@"uck_pcenter_pat_ok_circle"] forState:UIControlStateNormal];
    }
    self.is_choose = self.is_choose ? NO : YES;

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
