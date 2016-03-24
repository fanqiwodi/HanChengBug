//
//  UCarBCarInfoNameLabelTableViewCell.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoNameLabelTableViewCell.h"

@implementation UCarBCarInfoNameLabelTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.layer.cornerRadius = 15;
    self.titleLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
