//
//  HeaderLineView.m
//  Hancheng
//
//  Created by Tony on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HeaderLineView.h"

@implementation HeaderLineView

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
        [self setTopBottomLine];
    }
    return self;
}

- (void)setTopBottomLine
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    topView.backgroundColor = HEXCOLOR(0xe6e8eb);
    [self addSubview:topView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 1)];
    bottomView.backgroundColor = topView.backgroundColor;
    [self addSubview:bottomView];
}

@end
