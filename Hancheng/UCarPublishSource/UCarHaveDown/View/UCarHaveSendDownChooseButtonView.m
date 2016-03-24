//
//  UCarHaveSendDownChooseButtonView.m
//  Hancheng
//
//  Created by Tony on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarHaveSendDownChooseButtonView.h"

@implementation UCarHaveSendDownChooseButtonView

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
- (IBAction)upToSendAction:(id)sender {
    self.pageState(1);
}
- (IBAction)deleteAction:(id)sender {
    self.pageState(2);
}


@end
