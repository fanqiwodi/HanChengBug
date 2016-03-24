//
//  VIPSection2TableViewCell.m
//  Hancheng
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VIPSection2TableViewCell.h"

@implementation VIPSection2TableViewCell

- (void)setArr:(NSArray *)arr
{
    if (_arr != arr) {
        _arr = arr;
        _fImg.image = [UIImage imageNamed:[_arr firstObject][@"img"]];
        _lImg.image = [UIImage imageNamed:[_arr lastObject][@"img"]];
        NSMutableAttributedString *fstr = [[NSMutableAttributedString alloc] initWithString:[_arr firstObject][@"text"]];
        fstr.font = [UIFont systemFontOfSize:20*REM];
        fstr.color = [UIColor colorWithHexString:@"999999"];
        [fstr setFont:[UIFont systemFontOfSize:30*REM] range:NSMakeRange(0, 3)];
        [fstr setColor:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0, 3)];
        _fLabel.attributedText = fstr;
        
        NSMutableAttributedString *lstr = [[NSMutableAttributedString alloc] initWithString:[_arr lastObject][@"text"]];
        lstr.font = [UIFont systemFontOfSize:20*REM];
        lstr.color = [UIColor colorWithHexString:@"999999"];
        [lstr setFont:[UIFont systemFontOfSize:30*REM] range:NSMakeRange(0, 3)];
        [lstr setColor:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0, 3)];
        _lLabel.attributedText = lstr;
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
