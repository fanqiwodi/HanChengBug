//
//  UCarMineSellOrBuyTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarMineSellOrBuyTableViewCell.h"

@implementation UCarMineSellOrBuyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.lineState == 0) {
        self.sepLine.alpha = 0;
        self.topLine.alpha = self.bottomline.alpha = 1;
    } else if (self.lineState == 1) {
        self.bottomline.alpha = 0;
        self.topLine.alpha = self.sepLine.alpha = 1;
    } else if (self.lineState == 2) {
        self.topLine.alpha = self.sepLine.alpha = 0;
        self.bottomline.alpha = 1;
        
    }
    
    if ([self.titleLabel.text isEqualToString:@"我的买车订单"]) {
        self.titleImageView.image = [UIImage imageNamed:@"ico_buylist"];
    }
    
    if ([self.titleLabel.text isEqualToString:@"我的卖车订单"]) {
        self.titleImageView.image = [UIImage imageNamed:@"ico_selllist"];
    }
    
    if ([self.titleLabel.text isEqualToString:@"会员服务"]) {
        self.unReadLabel.text = @"";
        self.titleImageView.image = [UIImage imageNamed:@"ico_huiyuan"];
    }
    
    if ([self.titleLabel.text isEqualToString:@"设置"]) {
        self.unReadLabel.text = @"";
        self.titleImageView.image = [UIImage imageNamed:@"ico_set"];
    }
    
    self.unReadLabel.alpha = 1;
    if ([self.unReadString isEqualToString:@""]) {
        self.unReadLabel.alpha = 0;
    } else if([self.unReadString isEqualToString:@"0"]){
        self.unReadLabel.text = [NSString stringWithFormat:@"  %@  ",self.unReadString];
        self.unReadLabel.backgroundColor = HEXCOLOR(0x999999);
    } else {
        self.unReadLabel.backgroundColor = HEXCOLOR(0xff5000);
        self.unReadLabel.text = [NSString stringWithFormat:@"  %@  ",self.unReadString];

    }
}

- (UILabel *)unReadLabel
{
    _unReadLabel.textColor = HEXCOLOR(0xffffff);
    _unReadLabel.font = Font(13);
    _unReadLabel.backgroundColor = HEXACOLOR(0xff5000, 1);
    _unReadLabel.layer.cornerRadius = 8.5;
    _unReadLabel.layer.masksToBounds = YES;
    _unReadLabel.textAlignment = NSTextAlignmentLeft;
    return _unReadLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
