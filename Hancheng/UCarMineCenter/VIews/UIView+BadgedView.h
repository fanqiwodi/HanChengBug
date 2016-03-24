//
//  UIView+BadgedView.h
//  Hancheng
//
//  Created by why on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, WBadgeStyle)
{
    WBadgeStyleRedDot = 0,          /* 红点 */
    WBadgeStyleNumber             /* 数字 */
 
};



@interface UIView (BadgedView)
@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIFont *badgeFont;
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, assign) CGRect badgeFrame;
@property (nonatomic, assign) CGPoint  badgeCenterOffset;
@property (nonatomic, assign) NSInteger badgeValue;


- (void)showBadgeWithStyle:(WBadgeStyle)style value:(NSInteger)value;

- (void)clearBadge;

// 绘制一条线
- (CAShapeLayer *)creatLineWithColor:(UIColor *)color WithlineWidth:(CGFloat)lineWidth WithOriginalpoint:(CGPoint)oPoint WithDestinationPoint:(CGPoint)Dpoint;

// 截取屏幕转成UIImage
-(UIImage *)convertViewToImage;

@end
