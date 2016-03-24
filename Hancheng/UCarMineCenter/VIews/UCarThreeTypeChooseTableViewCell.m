//
//  UCarThreeTypeChooseTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarThreeTypeChooseTableViewCell.h"

@implementation UCarThreeTypeChooseTableViewCell
{
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *titleLableTip;
    __weak IBOutlet UILabel *titleLabelInfo;
    IBOutlet UIView *myMessageDot;
    
    IBOutlet UIView *bussinessDot;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    myMessageDot.layer.cornerRadius = bussinessDot.layer.cornerRadius = 3;
    myMessageDot.layer.masksToBounds = bussinessDot.layer.masksToBounds = YES;
    if (self.showMessageDot == 1) {
        myMessageDot.alpha = 1;
    } else {
        myMessageDot.alpha = 0;
    }
    
    if (self.showBussinessDot == 1) {
        bussinessDot.alpha = 1;
    } else {
        bussinessDot.alpha = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
