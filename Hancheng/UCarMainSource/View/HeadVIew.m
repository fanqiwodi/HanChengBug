//
//  HeadVIew.m
//  Hancheng
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HeadVIew.h"
#import "YYKit.h"
@implementation HeadVIew
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.redBanner = [UIImageView new];
        self.redBanner.backgroundColor = [UIColor colorWithHexString:@"ff5000"];
        [self addSubview:self.redBanner];
        self.letterL = [UILabel new];
        self.letterL.textColor = [UIColor colorWithHexString:WORDCOLOR];
        [self addSubview:self.letterL];
    }
    return self;
}

- (void)layoutSubviews
{
    WS(weakself);
    self.redBanner.frame = CGRectMake(0, 0, 5 *REM ,self.frame.size.height);
//    [self.redBanner mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.mas_top);
//        make.left.equalTo(weakself.mas_left);
//        make.bottom.equalTo(weakself.mas_bottom);
//        make.width.equalTo(@(5*REM));
//     
//    }];
    
    self.letterL.frame = CGRectMake(27 * REM, 0, self.frame.size.width - 27 * REM, self.frame.size.height);
//    [self.letterL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakself.mas_centerY);
//        make.left.equalTo(weakself.redBanner.mas_right).with.offset(22*REM);
//    }];
}
@end
