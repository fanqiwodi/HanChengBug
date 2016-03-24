//
//  UCarBInfoChooseTableViewCell.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBInfoChooseTableViewCell.h"

@implementation UCarBInfoChooseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_model) {
   
        self.titleLabel.text = _model.name;
        
        self.selectedIcon.layer.cornerRadius = 5;
        self.selectedIcon.layer.borderWidth = 2;
        NSNumber *isUse = [[NSNumber alloc] initWithInteger:1];
        NSNumber *unIsUse = [[NSNumber alloc] initWithInteger:0];
        if ([_model.isUse isEqualToNumber:isUse]) {
            self.selectedIcon.image = [UIImage imageNamed:@"iconfont_selectedRed"];
            self.selectedIcon.layer.borderColor = CARINFORRED.CGColor;
        }
        
        if ([_model.isUse isEqualToNumber:unIsUse]) {
            self.selectedIcon.image = [UIImage imageNamed:@"iconfont_unSelectedWhite"];
            self.selectedIcon.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        }

    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
