//
//  OrderTableViewCell.m
//  Hancheng
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.8f;
    lineShape.lineCap = kCALineCapRound;;
    lineShape.strokeColor = [UIColor colorWithHexString:@"F2F2F7"].CGColor;
    int x = self.img.right; int y = self.contentView.bottom+7;
    int toX = screen_width; int toY = self.contentView.bottom+7;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [self.contentView.layer addSublayer:lineShape];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
