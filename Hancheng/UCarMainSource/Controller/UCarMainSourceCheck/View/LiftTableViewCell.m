//
//  LiftTableViewCell.m
//  Hancheng
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LiftTableViewCell.h"

@implementation LiftTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.topB.userInteractionEnabled = NO;
  
}


-(void)layoutSubviews
{
    self.topB.titleLabel.font = [UIFont systemFontOfSize:22*REM];
    
}
- (void)setStr:(NSString *)str
{


}



@end
