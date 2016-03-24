//
//  UCarPhoneOrderView.m
//  Hancheng
//
//  Created by Tony on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarPhoneOrderView.h"

@implementation UCarPhoneOrderView
{
    
    __weak IBOutlet NSLayoutConstraint *phoneWidth;
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
    phoneWidth.constant = 125 * LAYOUT_SIZE;
}

- (IBAction)PhoneCallAction:(id)sender {
        self.pageState(0);
}
- (IBAction)OrderAction:(id)sender {
        self.pageState(1);
}

@end
