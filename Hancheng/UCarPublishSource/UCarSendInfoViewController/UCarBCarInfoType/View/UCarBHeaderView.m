//
//  UCarBHeaderView.m
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBHeaderView.h"

@implementation UCarBHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (UCarBHeaderView *)instanceView:(NSString *)title
{
    UCarBHeaderView *view = [[UCarBHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 25)];
    view.backgroundColor = BACKGROUNDCOLOR;
    UIView *redHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 25)];
    redHeader.backgroundColor = CARINFORRED;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREENWIDTH -12, 25)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = HEXCOLOR(0x999999);
    titleLabel.text = title;
    
    [view addSubview:redHeader];
    [view addSubview:titleLabel];
    return view;
}



@end
