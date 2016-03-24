//
//  UCarCompanyEditCellTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarCompanyEditCellTableViewCell.h"

@implementation UCarCompanyEditCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    switch (self.lineState) {
        case 0:
            _topLine.alpha = 1;
            _bottomLine.alpha = 1;
            _sepLine.alpha = 0;
            break;
        case 1:
            _topLine.alpha = 1;
            _bottomLine.alpha = 0;
            _sepLine.alpha = 1;
            break;
        case 2:
            _topLine.alpha = 0;
            _bottomLine.alpha = 1;
            _sepLine.alpha = 0;
            break;
        case 3:
            _topLine.alpha = 0;
            _bottomLine.alpha = 0;
            _sepLine.alpha = 1;
            break;
        default:
            _topLine.alpha = 1;
            _bottomLine.alpha = 0;
            _sepLine.alpha = 1;
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
