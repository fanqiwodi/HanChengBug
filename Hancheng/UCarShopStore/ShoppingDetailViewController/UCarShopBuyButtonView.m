//
//  UCarShopBuyButtonView.m
//  Hancheng
//
//  Created by Tony on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarShopBuyButtonView.h"

@implementation UCarShopBuyButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.sendButton.layer.cornerRadius = 20;
    self.sendButton.layer.masksToBounds = YES;
}

@end
