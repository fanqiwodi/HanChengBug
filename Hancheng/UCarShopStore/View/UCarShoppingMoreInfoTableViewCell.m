//
//  UCarShoppingMoreInfoTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarShoppingMoreInfoTableViewCell.h"

@implementation UCarShoppingMoreInfoTableViewCell
{
    __weak IBOutlet NSLayoutConstraint *firstImageWidth;
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    firstImageWidth.constant = 128.5 *LAYOUT_SIZE_iPhone5;
    if (SCREENWIDTH == 320) {
        self.personMadeLabel.font = Font(17);
        self.personMadeSecondLabel.font = Font(13);
        self.carCuringLabel.font = self.carPerformanceLabel.font = Font(15);
        self.carCuringSecondLabel.font = self.carPerformanceSecondLabel.font = Font(9);
    } else if (SCREENWIDTH == 375) {
        self.personMadeLabel.font = Font(19);
        self.personMadeSecondLabel.font = Font(14);
        self.carCuringLabel.font = self.carPerformanceLabel.font = Font(17);
        self.carCuringSecondLabel.font = self.carPerformanceSecondLabel.font = Font(11);
    } else {
        self.personMadeLabel.font = Font(19);
        self.personMadeSecondLabel.font = Font(14);
        self.carCuringLabel.font = self.carPerformanceLabel.font = Font(17);
        self.carCuringSecondLabel.font = self.carPerformanceSecondLabel.font = Font(11);
    }
}
- (IBAction)leftButtonAction:(id)sender {
    UCarShoppingMainViewModel_data_hotGoodsParts *model = [self.dataSource objectAtIndex:0];
    self.chooseIDAndName(model.id, model.name);
}
- (IBAction)rightTopButtonAction:(id)sender {
    UCarShoppingMainViewModel_data_hotGoodsParts *model = [self.dataSource objectAtIndex:1];
    self.chooseIDAndName(model.id, model.name);
}
- (IBAction)rightBottomAction:(id)sender {
    UCarShoppingMainViewModel_data_hotGoodsParts *model = [self.dataSource objectAtIndex:2];
    self.chooseIDAndName(model.id, model.name);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
