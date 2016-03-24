//
//  UCarSearchHeaderView.m
//  Hancheng
//
//  Created by Tony on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarSearchHeaderView.h"

@implementation UCarSearchHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BACKGROUNDCOLOR;
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:frame];
        tempLabel.text = [NSString stringWithFormat:@"  %@",title];
        tempLabel.font = [UIFont systemFontOfSize:13];
        tempLabel.textColor = HEXCOLOR(0x666666);
        tempLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:tempLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


@end
