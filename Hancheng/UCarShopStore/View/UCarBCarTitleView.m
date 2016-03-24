//
//  UCarBCarTitleView.m
//  Hancheng
//
//  Created by Tony on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarBCarTitleView.h"

@implementation UCarBCarTitleView
{
    UIView *_backView;
    UIView *_lineView;
}
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
        self.titleLabel = [[UILabel alloc] init];
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _lineView = [[UIView alloc] init];
        [_backView addSubview:_lineView];
        [_backView addSubview:_titleLabel];
        [self addSubview:_backView];
        self.backgroundColor = BACKGROUNDCOLOR;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _backView.frame = CGRectMake(0, 0, self.frame.size.width, 45);
    _lineView.backgroundColor = BACKGROUNDCOLOR;
    _lineView.frame = CGRectMake(0, 45, self.width, 1);
    _titleLabel.frame = CGRectMake(12, 0, 200, 45);
    _titleLabel.font = Font(15);
    _titleLabel.textColor = HEXCOLOR(0x333333);
    _titleLabel.text = @"热门推荐";
    
}

@end
