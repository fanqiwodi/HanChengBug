//
//  UCarSearchStepTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarSearchStepTableViewCell.h"

@implementation UCarSearchStepTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.pageState == 1) {
        self.titleLabel.textColor = HEXCOLOR(0xff5000);
    } else {
        self.titleLabel.textColor = HEXCOLOR(0x333333);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
