//
//  Right1TableViewCell.m
//  Hancheng
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Right1TableViewCell.h"

@implementation Right1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setIsClick:(BOOL)isClick
{
    
        if (isClick) {
            self.nameL.textColor = [UIColor colorWithHexString:@"FC583C"];
            if (self.str.length != 0) {
            self.ImageV.image = [UIImage imageNamed:@"iconfont_selectedRed"];
            }
        } else
        {
            self.nameL.textColor = [UIColor colorWithHexString:@"464646"];
            if (self.str.length != 0) {
                self.ImageV.image = [UIImage imageNamed:@"NOGX"];
            }        }
   
}


- (void)setStr:(NSString *)str
{
    _str = str;
    if (str.length == 0) {
        self.ImageV.image = nil;
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
  
}

@end
