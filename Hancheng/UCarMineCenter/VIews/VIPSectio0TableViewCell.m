//
//  VIPSectio0TableViewCell.m
//  Hancheng
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VIPSectio0TableViewCell.h"

@implementation VIPSectio0TableViewCell

- (void)setArr:(NSArray *)arr
{
    NSLog(@"-%@-", arr);
    if (_arr != arr) {
        _arr = arr;
        if ([[_arr lastObject] isEqualToNumber:@1]) {
            _midImg.image = [UIImage imageNamed:[_arr firstObject][@"unlock"]];
        } else {
            _midImg.image = [UIImage imageNamed:[_arr firstObject][@"lock"]];
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
