//
//  UCarLoginViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarLoginViewController.h"
#import "UCarForgotPasswordViewController.h"
#import "RegisterViewController.h"
#import "UCarRegisterNetwork.h"

@interface UCarLoginViewController ()

@end

@implementation UCarLoginViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setCornerRadius:self.unUserCoRadioPasswordView];
    [self setCornerRadius:self.unUserCorRadioPhoneNumberView];
    [self setCornerRadius:self.logInButton];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.logInButton.layer.borderWidth = 0;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)logInAction:(id)sender {
    
    if (self.inPutPhoneNumberTextField.text.length == 0) {
        [self showHint:@"请输入手机号码" yOffset:-300];
        return;
    }
    
    if (self.inPutPasswordTextField.text.length == 0) {
        [self showHint:@"请输入密码" yOffset:-300];
        return;
    }
    
    NSDictionary *params = @{@"userName":self.inPutPhoneNumberTextField.text,@"passWord":[UserMangerDefaults md5:self.inPutPasswordTextField.text],@"sysType":@1};
    
    [UCarRegisterNetwork POSTAddMemberLogin:params successBlk:^(id returnValue) {
        NSDictionary *resultDic = returnValue;
        NSNumber *codeNumber = [resultDic objectForKey:@"code"];
        if ([codeNumber isEqualToNumber:@0]) {
            [self showHint:@"登录成功" yOffset:-300];
            
            // 本地化
            UCARNSUSERDEFULTS(userDefaults);
            [userDefaults setBool:YES forKey:IS_LOGIN];
            NSString *uid = [[resultDic objectForKey:@"data"] objectForKey:@"uid"];
            [userDefaults setObject:uid forKey:GETUID];
            [UserMangerDefaults saveUserName:self.inPutPhoneNumberTextField.text password:self.inPutPasswordTextField.text];
            
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:CENTERLOGIN object:nil];
        } else {
            NSString *tipString = [resultDic objectForKey:@"msg"];
            [self showHint:tipString yOffset:-300];
        }
        
    } failuBlk:^(id error) {
        
    }];
    
}



// 忘记密码按钮
- (IBAction)forgotPasswordButtonAction:(id)sender {
    UCarForgotPasswordViewController *forgotPasswordVC = [[UCarForgotPasswordViewController alloc] initWithNibName:NSStringFromClass([UCarForgotPasswordViewController class]) bundle:nil];
    [self.navigationController pushViewController:forgotPasswordVC animated:YES];
}


// 注册
- (IBAction)registerAction:(id)sender {
    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:NSStringFromClass([RegisterViewController class]) bundle:nil];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

// 隐藏显示密码
- (IBAction)showPasswordAction:(id)sender {
    self.inPutPasswordTextField.secureTextEntry = self.inPutPasswordTextField.secureTextEntry  ? NO : YES;
    if (self.inPutPasswordTextField.secureTextEntry) {
        [self.showPasswordButton setImage:[UIImage imageNamed:@"login_sign_in_密码不可见_right"] forState:UIControlStateNormal];
    } else {
        [self.showPasswordButton setImage:[UIImage imageNamed:@"iconfont_eye"] forState:UIControlStateNormal];
    }
    
}


- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
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
