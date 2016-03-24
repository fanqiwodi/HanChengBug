//
//  UCarBCarInfoMustHaveTableViewCell.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoMustHaveTableViewCell.h"

@implementation UCarBCarInfoMustHaveTableViewCell
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleImageView.layer.cornerRadius = 15;
    self.titleImageView.layer.masksToBounds = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
