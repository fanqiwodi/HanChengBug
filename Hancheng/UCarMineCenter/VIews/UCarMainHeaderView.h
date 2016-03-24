
//
//  UCarMainHeaderView.h
//  Hancheng
//
//  Created by Tony on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarMainHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UIControl *selectedAction;
@property (weak, nonatomic) IBOutlet UIImageView *is_auth;
@property (weak, nonatomic) IBOutlet UIImageView *is_pay;

@property (nonatomic, strong) NSString *role_id;
@end
