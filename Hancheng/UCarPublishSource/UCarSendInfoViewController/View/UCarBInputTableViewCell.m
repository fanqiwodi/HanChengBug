//
//  UCarBInputTableViewCell.m
//  Hancheng
//
//  Created by Tony on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBInputTableViewCell.h"

@implementation UCarBInputTableViewCell 
{
    NSNotificationCenter *_center;
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.inPutTextField.delegate = self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.inPutTextField.text.length == 0) {
        self.moreInfoLabel.alpha = 1;
    } else {
        self.moreInfoLabel.alpha = 0;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.moreInfoLabel.alpha = 0;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.moreInfoLabel.alpha = 1; 
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
