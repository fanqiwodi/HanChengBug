//
//  UCarLoginViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarLoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *unUserCorRadioPhoneNumberView;
@property (weak, nonatomic) IBOutlet UIView *unUserCoRadioPasswordView;

@property (weak, nonatomic) IBOutlet UIButton *forgotPassword;
@property (weak, nonatomic) IBOutlet UIControl *logInButton;
@property (weak, nonatomic) IBOutlet UIControl *registerAction;


@property (weak, nonatomic) IBOutlet UIButton *showPasswordButton;
@property (weak, nonatomic) IBOutlet UITextField *inPutPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *inPutPasswordTextField;


@end
