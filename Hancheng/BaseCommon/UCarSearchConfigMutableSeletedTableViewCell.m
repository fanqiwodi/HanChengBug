//
//  UCarSearchConfigMutableSeletedTableViewCell.m
//  Hancheng
//
//  Created by Tony on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarSearchConfigMutableSeletedTableViewCell.h"

@implementation UCarSearchConfigMutableSeletedTableViewCell
{
    __weak IBOutlet UIImageView *selectedIcon;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
