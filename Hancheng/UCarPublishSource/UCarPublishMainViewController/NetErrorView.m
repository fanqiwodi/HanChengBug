//
//  NetErrorView.m
//  Hancheng
//
//  Created by 范琦 on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NetErrorView.h"

@implementation NetErrorView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width / 3.2, frame.size.height / 3.4,frame.size.width - frame.size.width / 3.2 - frame.size.width / 3.2, frame.size.height / 4)];
        imageV.image = [UIImage imageNamed:@"网络出问题"];
        [self addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.frame.origin.y + imageV.bounds.size.height + 20, frame.size.width, 30)];
        label.text = @"网络不稳定 , 请稍后再试 !";
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.alpha = 0.4;
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(frame.size.width / 3.7, label.frame.origin.y + 50,frame.size.width - frame.size.width / 3.7 - frame.size.width / 3.7 , frame.size.height / 15);
//        _button.backgroundColor = [UIColor redColor];
        [self addSubview:_button];
        [_button setTitle:@"刷新一下试试" forState:UIControlStateNormal];
        _button.tintColor = [UIColor blackColor];
        [_button.layer setMasksToBounds:YES];
        [_button.layer setCornerRadius:20]; //设置矩圆角半径
        [_button.layer setBorderWidth:1.0];   //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
        [_button.layer setBorderColor:colorref];//边框颜色
        _button.alpha = 0.5;
        

        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
