//
//  UCarSearchMainTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarSearchMainTableViewCell.h"

@implementation UCarSearchMainTableViewCell
{
    
    IBOutlet UIView *redHeaderView;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.pageState == 0) {
        self.backgroundColor = redHeaderView.backgroundColor = HEXCOLOR(0xf5f5f7);
        self.titleLabel.textColor = HEXCOLOR(0x666666);
        self.infoLabel.textColor =  HEXCOLOR(0x999999);
    } else {
        self.backgroundColor = HEXCOLOR(0xffffff);
//        self.infoLabel.textColor =
        self.titleLabel.textColor =  redHeaderView.backgroundColor = HEXCOLOR(0xff5000);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
