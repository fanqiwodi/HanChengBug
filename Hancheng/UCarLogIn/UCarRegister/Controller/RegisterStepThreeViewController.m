//
//  RegisterStepThreeViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RegisterStepThreeViewController.h"
#import "UCarRegisterNetwork.h"
#import "RegisterLastViewController.h"
#import "UCarProvinceViewController.h"

typedef NS_ENUM(NSInteger, roleType)
{
    roleTypeSellSelf = 1,
    roleTypeSellGroup,
    roleTypeSourceSelf,
    roleTypeSourceGroup,
};

@interface RegisterStepThreeViewController ()

@property (nonatomic, assign) roleType roleId;
@property (nonatomic, strong) NSString *secutryNumber;
@property (nonatomic, strong) NSDictionary *locationDictory;

@end

@implementation RegisterStepThreeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
        self.title = @"注册3/3";
        self.view.backgroundColor = BACKGROUNDCOLOR;
        self.inPutPhoneNumberTextField.text = self.phoneNumberString;
        [self setCornerRadius:self.unUseBaseViewPassword];
        [self setCornerRadius:self.unUseBaseViewPasswordAgain];
        [self setCornerRadius:self.unUseBaseViewPhoneNumberView];
        [self setCornerRadius:self.unUseBaseViewSecurityCodeView];
        [self setCornerRadius:self.labelCompanySource];
        [self setCornerRadius:self.labelPersonSource];
        [self setCornerRadius:self.chooseLocationView];
        self.LabelGetSecurityCode.layer.cornerRadius = 20;
        self.LabelGetSecurityCode.layer.masksToBounds = YES;
        self.LabelGetSecurityCode.layer.borderWidth = 1;
        self.LabelGetSecurityCode.layer.borderColor = HEXCOLOR(0xff5000).CGColor;
        self.makeSureSendButton.layer.cornerRadius = 20;
        self.makeSureSendButton.layer.masksToBounds = YES;
    });
    
    switch (self.userIdentity) {
        case 0:
            self.labelCompanySource.text = @"企业车源商";
            self.labelPersonSource.text = @"个人车源商";
            break;
            
        case 1:
            self.labelCompanySource.text = @"企业经销商";
            self.labelPersonSource.text  = @"汽车经纪人";
            break;
        default:
            break;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(changeLoactionName:) name:CENTERCITYNAME object:nil];
    self.secutryNumber = @"";
    self.roleId = 0;
    self.locationDictory = [NSDictionary new];
    UITapGestureRecognizer *sendMessageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendMessage)];
    self.LabelGetSecurityCode.userInteractionEnabled = YES;
    [self.LabelGetSecurityCode addGestureRecognizer:sendMessageTap];
    
    UITapGestureRecognizer *groupGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseGroup:)];
    self.labelCompanySource.userInteractionEnabled = YES;
    [self.labelCompanySource addGestureRecognizer:groupGesture];
    
    UITapGestureRecognizer *selfGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseSelf:)];
    self.labelPersonSource.userInteractionEnabled = YES;
    [self.labelPersonSource addGestureRecognizer:selfGesture];
}

#pragma mark 选择企业
- (void)chooseGroup:(UIGestureRecognizer *)gesture
{
    if (self.userIdentity == 0) {
        self.roleId = 4;
    } else if (self.userIdentity == 1) {
        self.roleId = 2;
    }
    
    self.labelCompanySource.backgroundColor = HEXCOLOR(0xff5000);
    self.labelCompanySource.textColor = HEXCOLOR(0xffffff);
    self.labelCompanySource.layer.borderColor = HEXCOLOR(0xff5000).CGColor;
    
    self.labelPersonSource.layer.borderColor = GRAYCOLOR;
    self.labelPersonSource.textColor = HEXCOLOR(0x333333);
    self.labelPersonSource.backgroundColor = HEXCOLOR(0xffffff);
}

- (void)chooseSelf:(UIGestureRecognizer *)Gesture
{
    if (self.userIdentity == 0) {
        self.roleId = 3;
    } else if (self.userIdentity == 1) {
        self.roleId = 1;
    }
    
    self.labelCompanySource.layer.borderColor = GRAYCOLOR;
    self.labelCompanySource.textColor =  HEXCOLOR(0x333333);
    self.labelCompanySource.backgroundColor = HEXCOLOR(0xffffff);
    
    self.labelPersonSource.layer.borderColor = HEXCOLOR(0xff5000).CGColor;
    self.labelPersonSource.textColor = HEXCOLOR(0xffffff);
    self.labelPersonSource.backgroundColor = HEXCOLOR(0xff5000);
}

- (IBAction)makeSureSend:(id)sender {
    

    if (![self.secutryNumber isEqualToString:self.inPutSecurityCodeNumberTextField.text] || self.inPutSecurityCodeNumberTextField.text.length != 6) {
        [self showHint:@"验证码错误" yOffset:-300];
        return;
    }
    
    if (self.inPutPasswordTextField.text.length > 16 || self.inPutPasswordTextField.text.length < 6 ) {
        [self showHint:@"请输入6-16位密码" yOffset:-300];
        return;
    }
    
    if (![self.inPutPasswordTextField.text isEqualToString:self.inPutPhoneNumberAgeinTextField.text]) {
        [self showHint:@"两次输入密码不一致" yOffset:-300];
        return;
    }
    
    if (self.roleId == 0) {
        [self showHint:@"请选择车源类别" yOffset:-300];
        return;
    }
    
    NSDictionary *params  = @{@"userName":self.phoneNumberString,@"passWord":[UserMangerDefaults md5:self.inPutPasswordTextField.text],@"sysType":@1, @"roleId":[NSNumber numberWithInteger:self.roleId]};
    [UCarRegisterNetwork POSTAddMemberChooseType:params successBlk:^(id returnValue) {
        NSDictionary *resultDic = returnValue;
        
        NSNumber *resultCode = [resultDic objectForKey:@"code"];
        if ([resultCode isEqualToNumber:@0]) {
            NSDictionary *data = [resultDic objectForKey:@"data"];
            NSString *uid = [data objectForKey:@"uid"];
            UCARNSUSERDEFULTS(userDefaults);
            [userDefaults setObject:uid forKey:GETUID];
            [userDefaults setBool:YES forKey:IS_LOGIN];
            [userDefaults setObject:[NSString stringWithFormat:@"%ld",(long)self.roleId] forKey:UCARROLE_ID];
            [UserMangerDefaults saveUserName:self.phoneNumberString password:self.inPutPasswordTextField.text];
            [userDefaults synchronize];
            RegisterLastViewController *registerLastVC = [[RegisterLastViewController alloc] init];
            registerLastVC.userIdentity = self.roleId;
            registerLastVC.registPhoneNumber = self.phoneNumberString;
            [self.navigationController pushViewController:registerLastVC animated:YES];
        } else {
            NSString *msg = [resultDic objectForKey:@"msg"];
            [self showHint:msg yOffset:-300];
        }
    } failuBlk:^(id error) {
        
    }];

    // 测试是最后一页
//    RegisterLastViewController *registerLastVC = [[RegisterLastViewController alloc] init];
//    registerLastVC.registPhoneNumber = self.phoneNumberString;
//    [self.navigationController pushViewController:registerLastVC animated:YES];

    
}
#pragma mark 选择城市
- (IBAction)chooseLocationButtonAction:(id)sender {
    
    UCarProvinceViewController *provinceVC = [[UCarProvinceViewController alloc] initWithNibName:NSStringFromClass([UCarProvinceViewController class]) bundle:nil];
    [self.navigationController pushViewController:provinceVC animated:YES];
}

- (void)changeLoactionName:(NSNotification *)notification
{
    self.locationDictory = notification.userInfo;
    
    NSString *locationName = [notification.userInfo objectForKey:@"name"];
    [self.chooseLocationButton setTitle:locationName forState:UIControlStateNormal];
    
}

#pragma mark 发送信息
- (void)sendMessage
{
    if ([self.LabelGetSecurityCode.text isEqualToString:@"获取验证码"]) {
        [self checkSendMessage];
        [self performSelector:@selector(changeSendButTitle:) withObject:[NSNumber numberWithInt:60] afterDelay:0];
    }
}

- (void)checkSendMessage
{
    NSMutableString *codeNumber = [NSMutableString string];
    for (NSInteger i = 0; i < 6;i++) {
        NSInteger j = arc4random() % 10 + 0;
        [codeNumber appendString:[NSString stringWithFormat:@"%ld",j]];
    }
    NSLog(@"%@",codeNumber);
    self.secutryNumber = codeNumber;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码" message:codeNumber delegate:self cancelButtonTitle:nil otherButtonTitles:@"朕知道了", nil];
//    [alert show];
    NSDictionary *param = @{@"phone":self.phoneNumberString,@"identifyingCode":codeNumber};
    [UCarRegisterNetwork POSTAddRegisterMember:param successBlk:^(id returnValue) {
        NSNumber *codeNumbers = returnValue;
        if ([codeNumbers isEqualToNumber:@0]) {
            [self showHint:@"验证码发送成功" yOffset:-300];
        } else {
            [self showHint:@"手机号码有误"];
            self.secutryNumber = @"";
        }
        
    } failuBlk:^(id error) {
        [self showHint:@"服务器维护中, 请稍后再试"];
    }];
}


-(void)changeSendButTitle:(NSNumber * )fromSecond{

    self.LabelGetSecurityCode.userInteractionEnabled = NO;
    int currentSecond=(int)[fromSecond integerValue];
    self.LabelGetSecurityCode.layer.borderColor = GRAYCOLOR;
    self.LabelGetSecurityCode.textColor = HEXCOLOR(0x999999);
    self.LabelGetSecurityCode.backgroundColor = HEXCOLOR(0xe8e8e8);
    self.LabelGetSecurityCode.text = [NSString stringWithFormat:@"重新发送(%d秒)",currentSecond];
    if (currentSecond<=0) {

        self.LabelGetSecurityCode.userInteractionEnabled = YES;
        self.LabelGetSecurityCode.text = @"获取验证码";
        self.LabelGetSecurityCode.layer.borderColor = HEXCOLOR(0xff5000).CGColor;
        self.LabelGetSecurityCode.backgroundColor = [UIColor clearColor];
        self.LabelGetSecurityCode.textColor = HEXCOLOR(0xff5000);
    }else{

        [self performSelector:@selector(changeSendButTitle:) withObject:[NSNumber numberWithInt:currentSecond-1] afterDelay:1.0];
    }
}

- (void)setCornerRadius:(UIView *)view
{
    view.layer.cornerRadius = 20;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = GRAYCOLOR;
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
