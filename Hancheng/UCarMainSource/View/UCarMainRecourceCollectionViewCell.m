//
//  UCarMainRecourceCollectionViewCell.m
//  Hancheng
//
//  Created by Tony on 16/2/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarMainRecourceCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@implementation UCarMainRecourceCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.fromTopSizeNumber.constant = 18 * LAYOUT_SIZE;
    self.carName.font = [UIFont systemFontOfSize:12*LAYOUT_SIZE];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.isHotString isEqualToString:@"1"]) {
        self.isHot.image = [UIImage imageNamed:@"hot"];
    } else {
        self.isHot.image = [UIImage imageNamed:@"No_hot_noexist"];
    }
    
    if (self.carLogoString) {
         [self.carLogo sd_setImageWithURL:[NSURL URLWithString:self.carLogoString] placeholderImage:[UIImage imageNamed:@"首页车标加载缺省"]];
    }
    
    if ([self.carLogoString isEqualToString:@""]) {
        self.carLogo.image = [UIImage imageNamed:@""];
    }
    if (self.carNameString) {
         self.carName.text = self.carNameString;   
    }
}

@end
