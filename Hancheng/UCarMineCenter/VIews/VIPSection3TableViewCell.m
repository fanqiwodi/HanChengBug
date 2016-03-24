//
//  VIPSection3TableViewCell.m
//  Hancheng
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VIPSection3TableViewCell.h"

@implementation VIPSection3TableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.img.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
