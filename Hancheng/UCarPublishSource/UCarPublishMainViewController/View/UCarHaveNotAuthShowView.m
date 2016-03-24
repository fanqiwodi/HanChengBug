//
//  UCarHaveNotAuthShowView.m
//  Hancheng
//
//  Created by Tony on 16/2/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarHaveNotAuthShowView.h"

@implementation UCarHaveNotAuthShowView
{
    
    __weak IBOutlet NSLayoutConstraint *buttonHeight;
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
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    
    buttonHeight.constant = 30 * LAYOUT_SIZE_iPhone5;
    self.makeSureButton.layer.cornerRadius = 15 * LAYOUT_SIZE_iPhone5;
    self.makeSureButton.layer.masksToBounds = YES;
}

@end
