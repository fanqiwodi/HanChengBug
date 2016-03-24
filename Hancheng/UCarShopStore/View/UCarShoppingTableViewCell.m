//
//  UCarShoppingTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarShoppingTableViewCell.h"

@implementation UCarShoppingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

// 内外饰点击
- (IBAction)selectedButtonIndex1:(id)sender {
    UCarShoppingMainViewModel_data_parentGoodsPartsCategory *model = [self.dataSource objectAtIndex:0];
    self.chooseTypeID(model.id, model.name);
}

// 性能点击
- (IBAction)selectedIndexButton2:(id)sender {
    UCarShoppingMainViewModel_data_parentGoodsPartsCategory *model = [self.dataSource objectAtIndex:1];
    self.chooseTypeID(model.id, model.name);
}

// 养护品点击
- (IBAction)selectedIndexButton3:(id)sender {
    UCarShoppingMainViewModel_data_parentGoodsPartsCategory *model = [self.dataSource objectAtIndex:2];
    self.chooseTypeID(model.id, model.name);
}

// 更多点击
- (IBAction)selectedIndexButton4:(id)sender {
    UCarShoppingMainViewModel_data_parentGoodsPartsCategory *model = [self.dataSource objectAtIndex:3];
    self.chooseTypeID(model.id, model.name);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
