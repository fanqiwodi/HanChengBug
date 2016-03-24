//
//  RegisterSetpTwoViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UserIdentity) {
    userIdentityCarSource= 0,  // 车源商
    userIdentitySellOwer,      // 经销商
};

@interface RegisterSetpTwoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *unUseBaseView;
@property (weak, nonatomic) IBOutlet UIControl *buttonNextStep;
@property (weak, nonatomic) IBOutlet UITextField *inPutPhoneNumberTextField;
@property (nonatomic, assign)UserIdentity userIdentity;

@end
