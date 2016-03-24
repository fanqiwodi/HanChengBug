//
//  UCarBuyOrSellOrderTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarBuyOrSellOrderTableViewCell.h"

@implementation UCarBuyOrSellOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单:%@",self.model.order_sn];
    self.orderStateLabel.alpha = 1;
    
   if ([self.orderStateString isEqualToString:@"交易关闭"]) {
        self.orderStateLabel.backgroundColor = HEXCOLOR(0x999999);
    } else if ([self.orderStateString isEqualToString:@""]) {
         self.orderStateLabel.alpha = 0;
    } else {
        self.orderStateLabel.backgroundColor = HEXCOLOR(0x239aec);
    }
    self.orderStateLabel.text = [NSString stringWithFormat:@"  %@  ",self.orderStateString];
    
    self.orderTimeLabel.text = self.model.modify_datetime;
    if ([self.model.spotsName isEqualToString:@""]) {
    self.orderTitleLabel.text = [NSString stringWithFormat:@"%@",self.model.goodsName];
    } else {
    self.orderTitleLabel.text = [NSString stringWithFormat:@"%@【%@】",self.model.goodsName, self.model.spotsName];
    }
    
    if (![self.model.type isEqualToString:@"1"]) {
        self.orderDealPriceLabel.text = [NSString stringWithFormat:@"成交价:%@万元",self.model.price];
    } else
    {
         self.orderDealPriceLabel.text = [NSString stringWithFormat:@"成交价:%@元",self.model.price];
    }
    
    if ([self.model.earnest isEqualToString:@"0"]) {
        self.orderFrontMoneyLabel.text = @"";
    } else {
    self.orderFrontMoneyLabel.text = [NSString stringWithFormat:@"定金:%@元", self.model.earnest];
    }
}


- (UILabel *)orderStateLabel
{
    _orderStateLabel.layer.cornerRadius = 8;
    _orderStateLabel.layer.masksToBounds = YES;
    _orderStateLabel.textAlignment = NSTextAlignmentLeft;
    return _orderStateLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
