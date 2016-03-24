//
//  RegisterStepThreeViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RegisterStepThreeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *unUseBaseViewPhoneNumberView;
@property (weak, nonatomic) IBOutlet UIView *unUseBaseViewSecurityCodeView;
@property (weak, nonatomic) IBOutlet UIView *unUseBaseViewPassword;
@property (weak, nonatomic) IBOutlet UIView *unUseBaseViewPasswordAgain;


@property (weak, nonatomic) IBOutlet UILabel *labelCompanySource;
@property (weak, nonatomic) IBOutlet UILabel *labelPersonSource;

@property (weak, nonatomic) IBOutlet UIControl *makeSureSendButton;
@property (weak, nonatomic) IBOutlet UILabel *LabelGetSecurityCode;
@property (weak, nonatomic) IBOutlet UITextField *inPutPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *inPutSecurityCodeNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *inPutPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *inPutPhoneNumberAgeinTextField;
@property (weak, nonatomic) IBOutlet UIView *chooseLocationView;
@property (weak, nonatomic) IBOutlet UIButton *chooseLocationButton;

@property (nonatomic, strong)NSString *phoneNumberString;

@property (nonatomic, assign)NSInteger userIdentity;

@end
