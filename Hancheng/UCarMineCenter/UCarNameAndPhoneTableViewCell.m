//
//  UCarNameAndPhoneTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarNameAndPhoneTableViewCell.h"

@implementation UCarNameAndPhoneTableViewCell
{
    __weak IBOutlet UIView *topLine;
    __weak IBOutlet UIView *bottomLine;
    __weak IBOutlet UIView *sepLine;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    switch (self.lineState) {
        case 0:
            topLine.alpha = 1;
            bottomLine.alpha = 1;
            sepLine.alpha = 0;
            break;
        case 1:
            topLine.alpha = 1;
            bottomLine.alpha = 0;
            sepLine.alpha = 1;
            break;
        case 2:
            topLine.alpha = 0;
            bottomLine.alpha = 1;
            sepLine.alpha = 0;
            break;
        case 3:
            topLine.alpha = 0;
            bottomLine.alpha = 0;
            sepLine.alpha = 1;
            break;
        default:
            topLine.alpha = 1;
            bottomLine.alpha = 0;
            sepLine.alpha = 1;
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end