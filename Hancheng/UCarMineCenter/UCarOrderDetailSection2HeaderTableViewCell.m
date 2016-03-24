//
//  UCarOrderDetailSection2HeaderTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarOrderDetailSection2HeaderTableViewCell.h"

@implementation UCarOrderDetailSection2HeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    

//        self.orderStateLabel.backgroundColor = HEXCOLOR(0x25ae5f);
     if ([self.orderStateString isEqualToString:@"交易关闭"]) {
        self.orderStateLabel.backgroundColor = HEXCOLOR(0x999999);
    } else if ([self.orderStateString isEqualToString:@""]) {
        self.orderStateLabel.alpha = 0;
    } else {
        self.orderStateLabel.backgroundColor = HEXCOLOR(0x239aec);
    }
    self.orderStateLabel.text = [NSString stringWithFormat:@"  %@  ",self.orderStateString];
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
