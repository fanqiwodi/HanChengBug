//
//  UCarShoppingOrderTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarShoppingOrderTableViewCell.h"

@implementation UCarShoppingOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_model.imageSMURL,_model.listImg]] placeholderImage:[UIImage imageNamed:@"商场列表缩略图缺省"]];
    self.goodNameLabel.text = _model.name;
    self.goodTimeLabel.text = _model.modifyDatetime;
    
//    if (![_model.shopPrice isEqualToString:@""] && ![_model.shopPrice1 isEqualToString:@""]) {
//        self.goodPriceLabel.text = [NSString stringWithFormat:@"%@ - %@元",_model.shopPrice, _model.shopPrice1];
//    } else {
        self.goodPriceLabel.text = [NSString stringWithFormat:@"%@元",_model.shopPrice];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
