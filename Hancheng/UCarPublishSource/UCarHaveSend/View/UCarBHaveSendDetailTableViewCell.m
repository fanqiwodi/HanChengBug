//
//  UCarBHaveSendDetailTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarBHaveSendDetailTableViewCell.h"

@implementation UCarBHaveSendDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.pageState == 0) {
        self.numberCodeLabel.textColor = self.priceLabel.textColor = self.colorView.backgroundColor = HEXCOLOR(0xff5000);
        self.stateImageView.image = [UIImage imageNamed:@"iconfont_HaveUpIConTip"];
    } else {
        self.numberCodeLabel.textColor = self.priceLabel.textColor = self.colorView.backgroundColor = HEXCOLOR(0x666666);
        self.stateImageView.image = [UIImage imageNamed:@"iconfon_HaveDownIConTip"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
