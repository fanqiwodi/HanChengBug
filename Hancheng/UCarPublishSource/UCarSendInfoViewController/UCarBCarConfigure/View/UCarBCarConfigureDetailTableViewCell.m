//
//  UCarBCarConfigureDetailTableViewCell.m
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarConfigureDetailTableViewCell.h"

@implementation UCarBCarConfigureDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.selectedImageView.layer.cornerRadius = 5;
    self.selectedImageView.layer.borderWidth = 2;
    if ([_is_Use isEqualToString:@"1"]) {
        self.selectedImageView.image = [UIImage imageNamed:@"iconfont_selectedRed"];
        self.selectedImageView.layer.borderColor = CARINFORRED.CGColor;
        self.infoLabel.textColor = CARINFORRED;
    }
    
    if ([_is_Use isEqualToString:@"0"]) {
        self.selectedImageView.image = [UIImage imageNamed:@"iconfont_unSelectedWhite"];
        self.selectedImageView.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        self.infoLabel.textColor = HEXCOLOR(0x333333);
    }
}
- (IBAction)didSelectShowDetail:(id)sender {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:CENTERDETAILBUTTON object:[NSString stringWithFormat:@"%ld",self.indexRow]];
}

- (void)dealloc{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
