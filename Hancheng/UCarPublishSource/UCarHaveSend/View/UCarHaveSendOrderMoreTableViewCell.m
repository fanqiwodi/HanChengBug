//
//  UCarHaveSendOrderMoreTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarHaveSendOrderMoreTableViewCell.h"

@implementation UCarHaveSendOrderMoreTableViewCell
{
    __weak IBOutlet NSLayoutConstraint *leadingMargin;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    leadingMargin.constant = 92 *LAYOUT_SIZE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
