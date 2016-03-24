//
//  UCarFindPasswordViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarFindPasswordViewController : BaseViewController

@property (nonatomic, strong) NSString *inputTextFieldStrPhoneNumber;

@property (weak, nonatomic) IBOutlet UIView *unUseBaseViewPhoneNumber;
@property (weak, nonatomic) IBOutlet UIView *unUseBaseViewSecurityCode;
@property (weak, nonatomic) IBOutlet UIView *unUseBaseViewPassword;
@property (weak, nonatomic) IBOutlet UIView *unUseBaseViewPasswordAgain;


@property (weak, nonatomic) IBOutlet UIControl *buttonMakeSureSend;
@property (weak, nonatomic) IBOutlet UITextField *inPutPhoneNumberTextFieldUserEnableNO;
@property (weak, nonatomic) IBOutlet UITextField *inPutSecurityCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *inPutNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *inPutPasswordAgain;


@property (weak, nonatomic) IBOutlet UILabel *LabelGETSecurityCode;

@end
