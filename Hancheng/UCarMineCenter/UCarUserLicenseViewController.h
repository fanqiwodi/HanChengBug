//
//  UCarUserLicenseViewController.h
//  Hancheng
//
//  Created by Tony on 16/2/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarUserLicenseViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *UCarCertificationImageView; //顶部原型图片
@property (weak, nonatomic) IBOutlet UILabel *UCarCertificationLabel;         // 顶部实名认证 让买卖直接
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewHeight;      // 第二部分高度, 决定显示内容
@property (weak, nonatomic) IBOutlet UIView *identifiyNumberLabel;            // 第二行输
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;                  // 第一行真实姓名Label
@property (weak, nonatomic) IBOutlet UITextField *realNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *identiflyNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *identiflyTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerNowButton;
@property (weak, nonatomic) IBOutlet UIButton *dotButton;
@property (weak, nonatomic) IBOutlet UIButton *agreementButton;
@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *firstView;




// 传过来参数
@property(nonatomic, strong)  NSString *isAuth;
@property (nonatomic, strong) NSString *licienceImageUrl;
@property (nonatomic, strong) NSString *role_id;
@property (nonatomic, assign) NSInteger pageState;

@end
