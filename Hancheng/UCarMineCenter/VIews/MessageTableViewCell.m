//
//  MessageTableViewCell.m
//  Hancheng
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "UIView+BadgedView.h"
@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    CAShapeLayer *shaplayer = [self.contentView creatLineWithColor:[UIColor colorWithHexString:@"e6e8eb"] WithlineWidth:0.8f WithOriginalpoint:CGPointMake(0, self.contentL.top+5) WithDestinationPoint:CGPointMake(screen_width, self.contentL.top+5)];
    [self.contentView.layer addSublayer:shaplayer];

}


- (void)setDic:(NSDictionary *)dic
{
    if (_dic != dic) {
        _dic = dic;
        if ([_dic[@"type"] isEqualToString:@"1"]) {
            _kindL.text = @"系统消息";
            _img.image = [UIImage imageNamed:@"uck_pcenter_message_type_system"];
        }
        if ([_dic[@"type"] isEqualToString:@"2"]) {
            _kindL.text = @"管理员信息";
            _img.image = [UIImage imageNamed:@"uck_pcenter_message_type_admin"];
        }
        if ([_dic[@"type"] isEqualToString:@"3"]) {
            _kindL.text = @"车品信息";
              _img.image = [UIImage imageNamed:@"uck_pcenter_message_type_cartime"];
            
        }
        if ([_dic[@"type"] isEqualToString:@"4"]) {
            _kindL.text = @"客服信息";
            _img.image = [UIImage imageNamed:@"uck_pcenter_message_type_cutom_service"];
        }
        if ([_dic[@"type"] isEqualToString:@"5"]) {
            _kindL.text = @"交易信息";
        }
        _contentL.text = _dic[@"content"];

    
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[_dic[@"time"] substringToIndex:10] integerValue]];
        _timeL.text = [date stringWithFormat:@"yyyy-MM-dd HH:MM:ss"];
    

        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
