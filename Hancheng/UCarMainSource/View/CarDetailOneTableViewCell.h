//
//  CarDetailOneTableViewCell.h
//  Hancheng
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarbandDetailModel.h"
@interface CarDetailOneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serialNumber;
@property (weak, nonatomic) IBOutlet UILabel *carName;
@property (weak, nonatomic) IBOutlet UILabel *price_time;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *preMoney;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UIView *leftVIew;
@property (weak, nonatomic) IBOutlet UIView *rightView;


@property (nonatomic, copy)CarbandDetailModel1 *model;

@property (weak, nonatomic) IBOutlet UIImageView *uSpecialImg;

@property (nonatomic, strong) NSString *status;
@end
