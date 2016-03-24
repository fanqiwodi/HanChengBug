//
//  UCarBuyOrSellOrderTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_47_BuyCarModel+NetAction.h"

@interface UCarBuyOrSellOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDealPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderFrontMoneyLabel;

@property (nonatomic, strong) NSString *orderStateString;
@property (nonatomic, strong) C_47_BuyCarModel_Chlid *model;

@end
