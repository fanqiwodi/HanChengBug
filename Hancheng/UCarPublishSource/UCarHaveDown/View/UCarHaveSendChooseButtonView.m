//
//  UCarHaveSendChooseButtonView.m
//  Hancheng
//
//  Created by Tony on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarHaveSendChooseButtonView.h"

@implementation UCarHaveSendChooseButtonView

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
}

- (IBAction)shareButton:(id)sender {
    self.pageState(0);
}
- (IBAction)sendToTop:(id)sender {
    self.pageState(1);
}
- (IBAction)sendToDown:(id)sender {
    self.pageState(2);
}
- (IBAction)deteleAction:(id)sender {
    self.pageState(3);
}

@end
