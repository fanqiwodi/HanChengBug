//
//  UCarBCarConfigureTableViewCell.m
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarConfigureTableViewCell.h"

@implementation UCarBCarConfigureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.selectedIcon.layer.cornerRadius = 5;
    self.selectedIcon.layer.borderWidth = 2;
    if ([_is_Use isEqualToString:@"1"]) {
        self.selectedIcon.image = [UIImage imageNamed:@"iconfont_selectedRed"];
        self.selectedIcon.layer.borderColor = CARINFORRED.CGColor;
        self.infoLabel.textColor =  CARINFORRED;
    }
    
    if ([_is_Use isEqualToString:@"0"]) {
        self.selectedIcon.image = [UIImage imageNamed:@"iconfont_unSelectedWhite"];
        self.selectedIcon.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        self.infoLabel.textColor = HEXCOLOR(333333);
    }
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
