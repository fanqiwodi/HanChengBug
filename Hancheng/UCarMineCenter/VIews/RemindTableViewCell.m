//
//  RemindTableViewCell.m
//  Hancheng
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RemindTableViewCell.h"

@implementation RemindTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    画一条线
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.5f;
    lineShape.lineCap = kCALineCapRound;;
    lineShape.strokeColor = [UIColor colorWithHexString:@"F2F2F7"].CGColor;
    int x = self.backgoundV.left; int y = self.contentL.bottom + 55*REM;
    int toX = screen_width-15; int toY = self.contentL.bottom + 55*REM;
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
