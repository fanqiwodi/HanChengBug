//
//  UCarNoNetwork.m
//  Hancheng
//
//  Created by Tony on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarNoNetwork.h"

@implementation UCarNoNetwork

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
    self.reflashButton.layer.cornerRadius = 18;
    self.reflashButton.layer.masksToBounds = YES;
    self.reflashButton.layer.borderColor = HEXCOLOR(0x444444).CGColor;
    self.reflashButton.layer.borderWidth = 1;
}

@end
