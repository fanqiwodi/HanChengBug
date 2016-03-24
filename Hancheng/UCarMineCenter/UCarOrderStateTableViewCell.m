//
//  UCarOrderStateTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarOrderStateTableViewCell.h"

@implementation UCarOrderStateTableViewCell
{
    __weak IBOutlet NSLayoutConstraint *dotTop;
    __weak IBOutlet NSLayoutConstraint *dotWidth;
    __weak IBOutlet NSLayoutConstraint *dotHeight;
    __weak IBOutlet UIView *updotLine;
    __weak IBOutlet UIView *downDotLine;
    __weak IBOutlet UIView *dotOutsideView;
    
    __weak IBOutlet UIView *topLine;
    __weak IBOutlet UIView *bottomLine;
    __weak IBOutlet UIView *sepLine;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
//    0第一个不是当前 1过程中不是当前 2第一个为当前 3过程中为当前 4底部 5只有一个当前状态 6底部为最后一个
    [super layoutSubviews];
    dotOutsideView.layer.cornerRadius = 5;
    dotOutsideView.layer.backgroundColor = HEXCOLOR(0x999999).CGColor;
    [self setviewForState];
}
- (void)setviewForState
{
    self.orderDetailCarState.textColor = HEXCOLOR(0x999999);
    self.orderDetailTimeLabel.textColor = HEXCOLOR(0x999999);
    if (self.pageState == 0) {
        updotLine.alpha = 0;
        downDotLine.alpha = 1;
        downDotLine.backgroundColor = HEXCOLOR(0x999999);
        dotOutsideView = [self setViewBorder:dotOutsideView];
    }
    if (self.pageState == 1) {
        updotLine.alpha = 1;
        downDotLine.alpha = 1;
        topLine.alpha = 0;
        sepLine.alpha = 1;
        bottomLine.alpha = 0;
        updotLine.backgroundColor = downDotLine.backgroundColor = HEXCOLOR(0x999999);
        dotOutsideView = [self setViewBorder:dotOutsideView];
    }
    if (self.pageState == 2) {
        updotLine.alpha = 0;
        self.orderDetailTimeLabel.textColor = HEXCOLOR(0xff5000);
        self.orderDetailCarState.textColor = HEXCOLOR(0xff5000);
        downDotLine.alpha = 1;
        topLine.alpha = 1;
        sepLine.alpha = 1;
        bottomLine.alpha = 0;
        downDotLine.backgroundColor = HEXCOLOR(0x999999);
        dotOutsideView = [self setViewBorder:dotOutsideView];
    }
    if (self.pageState == 3) {
        updotLine.alpha = 1;
        updotLine.backgroundColor = HEXCOLOR(0xff5000);
        downDotLine.alpha = 1;
        self.orderDetailTimeLabel.textColor = HEXCOLOR(0xff5000);
        self.orderDetailCarState.textColor = HEXCOLOR(0xff5000);
        downDotLine.backgroundColor = HEXCOLOR(0x999999);
        dotOutsideView = [self setViewBorder:dotOutsideView];
    }
    if (self.pageState == 4) {
        updotLine.alpha = 1;
        topLine.alpha = 0;
        bottomLine.alpha = 1;
        sepLine.alpha = 0;
        updotLine.backgroundColor = HEXCOLOR(0x999999);
        downDotLine.alpha = 0;
        dotOutsideView = [self setViewBorder:dotOutsideView];
    }
    if (self.pageState == 5) {
        updotLine.alpha = 0;
        self.orderDetailTimeLabel.textColor = HEXCOLOR(0xff5000);
        self.orderDetailCarState.textColor = HEXCOLOR(0xff5000);
        
        topLine.alpha = bottomLine.alpha = 1;
        sepLine.alpha = 0;
        updotLine.backgroundColor = HEXCOLOR(0x999999);
        downDotLine.alpha = 0;
        dotOutsideView = [self setViewBorder:dotOutsideView];
    }
    if (self.pageState == 6) {
        updotLine.alpha = 1;
        updotLine.backgroundColor = HEXCOLOR(0xff5000);
        downDotLine.alpha = 0;
        dotOutsideView = [self setViewBorder:dotOutsideView];
    }
}

- (UIView *)setViewBorder:(UIView *)dot
{
    if (self.pageState == 0 || self.pageState == 1 || self.pageState == 4) {
        dot.layer.borderColor = [UIColor clearColor].CGColor;
        dot.backgroundColor = HEXCOLOR(0x999999);
        dot.layer.borderWidth = 0;
    }
    if (self.pageState == 2 || self.pageState == 3 || self.pageState == 5 || self.pageState == 6) {
        dot.layer.borderColor = HEXCOLOR(0xffcfb9).CGColor;
        dot.backgroundColor = HEXCOLOR(0xff5000);
        dotOutsideView.layer.cornerRadius = 7;
        dotTop.constant = 15;
        dotHeight.constant = dotWidth.constant = 14;
        dot.layer.borderWidth = 2;
    }
    return dot;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
