//
//  UCarFindPasswordViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarFindPasswordViewController.h"
#import "UCarRegisterNetwork.h"

@interface UCarFindPasswordViewController ()
@property (nonatomic, strong) NSString *secutryNumber;
@end

@implementation UCarFindPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = @"找回密码";
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
        self.view.backgroundColor = BACKGROUNDCOLOR;
        self.inPutPhoneNumberTextFieldUserEnableNO.text = self.inputTextFieldStrPhoneNumber;
        [self setCornerRadius:self.unUseBaseViewPassword];
        [self setCornerRadius:self.unUseBaseViewPasswordAgain];
        [self setCornerRadius:self.unUseBaseViewPhoneNumber];
        [self setCornerRadius:self.unUseBaseViewSecurityCode];
        [self setCornerRadius:self.LabelGETSecurityCode];
        [self setCornerRadius:self.buttonMakeSureSend];
        self.buttonMakeSureSend.layer.borderColor = self.LabelGETSecurityCode.layer.borderColor = HEXCOLOR(0xFF5000).CGColor;
    });
}
- (IBAction)makeSurceChange:(id)sender {
    
    if (![self.inPutSecurityCodeTextField.text isEqualToString:self.secutryNumber]) {
        [self showHint:@"验证码错误" yOffset:-300];
        return;
    }
    
    if (self.inPutPasswordAgain.text.length > 16 || self.inPutPasswordAgain.text.length < 6 ) {
        [self showHint:@"请输入6-16位密码" yOffset:-300];
        return;
    }
    
    if (![self.inPutPasswordAgain.text isEqualToString:self.inPutNewPasswordTextField.text]) {
        [self showHint:@"两次输入密码不一致" yOffset:-300];
        return;
    }
    
    NSDictionary *params = @{@"userName":self.inPutPhoneNumberTextFieldUserEnableNO.text, @"passWord":[UserMangerDefaults md5:self.inPutPasswordAgain.text]};
    [UCarRegisterNetwork PUTediMemberPassword:params successBlk:^(id returnValue) {
        NSDictionary *resultDic = returnValue;
        NSNumber *code = [resultDic objectForKey:@"code"];
        if ([code isEqualToNumber:@0]) {
            [self showHint:@"密码修改成功" yOffset:-300];
            [UserMangerDefaults saveUserName:self.inPutPhoneNumberTextFieldUserEnableNO.text password:self.inPutPasswordAgain.text];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        } else {
            NSString *tipString = [resultDic objectForKey:@"msg"];
            [self showHint:tipString yOffset:-300];
        }
    } failuBlk:^(id error) {
        
    }];
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *securityCodeButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendMessage)];
    self.LabelGETSecurityCode.userInteractionEnabled = YES;
    [self.LabelGETSecurityCode addGestureRecognizer:securityCodeButton];
    
    
}

- (void)sendMessage
{
    if ([self.LabelGETSecurityCode.text isEqualToString:@"获取验证码"]) {
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
    self.secutryNumber = codeNumber;
    NSDictionary *param = @{@"phone":self.inputTextFieldStrPhoneNumber,@"identifyingCode":codeNumber};
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
    
    self.LabelGETSecurityCode.userInteractionEnabled = NO;
    int currentSecond=(int)[fromSecond integerValue];
    self.LabelGETSecurityCode.layer.borderColor = GRAYCOLOR;
    self.LabelGETSecurityCode.textColor = HEXCOLOR(0x999999);
    self.LabelGETSecurityCode.backgroundColor = HEXCOLOR(0xe8e8e8);
    self.LabelGETSecurityCode.text = [NSString stringWithFormat:@"重新发送(%d秒)",currentSecond];
    if (currentSecond<=0) {
        
        self.LabelGETSecurityCode.userInteractionEnabled = YES;
        self.LabelGETSecurityCode.text = @"获取验证码";
        self.LabelGETSecurityCode.layer.borderColor = HEXCOLOR(0xff5000).CGColor;
        self.LabelGETSecurityCode.backgroundColor = [UIColor clearColor];
        self.LabelGETSecurityCode.textColor = HEXCOLOR(0xff5000);
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
