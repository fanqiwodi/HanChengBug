//
//  BuyorSellOrderTableViewCell.m
//  Hancheng
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BuyorSellOrderTableViewCell.h"
#import "UIView+BadgedView.h"

@implementation BuyorSellOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
  CAShapeLayer *shaplayer = [self.contentView creatLineWithColor:[UIColor colorWithHexString:@"F2F2F7"] WithlineWidth:0.8f WithOriginalpoint:CGPointMake(0, 100*REM) WithDestinationPoint:CGPointMake(screen_width, 100*REM)];
    UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.nameL.top+10, 3, self.nameL.height-3)];
    redLine.backgroundColor = [UIColor colorWithHexString:@"F55226"];
    [self.contentView addSubview:redLine];
    
    [self.contentView.layer addSublayer:shaplayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
