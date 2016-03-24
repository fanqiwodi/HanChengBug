
//
//  UCarMainHeaderView.m
//  Hancheng
//
//  Created by Tony on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarMainHeaderView.h"

@implementation UCarMainHeaderView
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.nameLabel.text isEqualToString:@""]) {
        self.nameLabel.text = @"昵称未填写";
    }
    
    if ([self.companyLabel.text isEqualToString:@""]) {
        self.companyLabel.text = @"公司未填写";
    }
    
    if ([self.role_id isEqualToString:@"1"]) {
        self.checkImageView.image = [UIImage imageNamed:@"ico_qichejingjiren"];
    } else if ([self.role_id isEqualToString:@"2"]) {
        self.checkImageView.image = [UIImage imageNamed:@"ico_qiyejingxiaoshang"];
    } else if ([self.role_id isEqualToString:@"3"]) {
        self.checkImageView.image = [UIImage imageNamed:@"ico_gerencheyuanshang"];
    } else if ([self.role_id isEqualToString:@"4"]) {
        self.checkImageView.image = [UIImage imageNamed:@"ico_qiyecheyuanshang"];
    }
}

@end
