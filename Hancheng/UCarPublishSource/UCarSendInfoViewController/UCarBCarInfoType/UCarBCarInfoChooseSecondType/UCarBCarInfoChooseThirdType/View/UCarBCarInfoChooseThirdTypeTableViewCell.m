//
//  UCarBCarInfoChooseThirdTypeTableViewCell.m
//  Hancheng
//
//  Created by Tony on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseThirdTypeTableViewCell.h"

@implementation UCarBCarInfoChooseThirdTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if ([self.priceLabel.text isEqualToString:@"0.00万"]) {
        self.priceLabel.text = @"";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
