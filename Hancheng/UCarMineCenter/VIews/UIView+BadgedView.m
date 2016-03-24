//
//  UIView+BadgedView.m
//  Hancheng
//
//  Created by why on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//
#import <objc/runtime.h>
#import "UIView+BadgedView.h"
#define BadgeDefaultFont ([UIFont boldSystemFontOfSize:9])
#define BadgeMaximumBadgeNumber 99
static char badgeLabelKey;
static char badgeBgColorKey;
static char badgeFontKey;
static char badgeTextColorKey;
static char badgeFrameKey;
static char badgeCenterOffsetKey;
static char badgeValueKey;


@implementation UIView (BadgedView)

- (void)showBadgeWithStyle:(WBadgeStyle)style value:(NSInteger)value
{
    switch (style) {
        case WBadgeStyleRedDot:
            [self showRedDotBadge];
            break;
        case WBadgeStyleNumber:
        [self showNumberBadgeWithValue:value];
            break;
        default:
            break;
    }
}
- (void)clearBadge
{
    self.badge.hidden = YES;
}

- (void)showNumberBadgeWithValue:(NSInteger)value
{
    if (value < 0) {
        return;
    }
    [self badgeInit];
//    self.badge.hidden = (value == 0);
    self.badge.tag = WBadgeStyleNumber;
    self.badge.font = self.badgeFont;
    self.badge.text = (value >= BadgeMaximumBadgeNumber ?
                       [NSString stringWithFormat:@"%@+", @(BadgeMaximumBadgeNumber)] :
                       [NSString stringWithFormat:@"%@", @(value)]);
    [self adjustLabelWidth:self.badge];
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    if(CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}
- (void)showRedDotBadge
{
    [self badgeInit];
    //if badge has been displayed and, in addition, is was not red dot style, we must update UI.
   
    self.badge.text = @"";
    
    self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
 
    self.badge.hidden = NO;
}

//lazy loading
- (void)badgeInit
{
    if (self.badgeBgColor == nil) {
        self.badgeBgColor = [UIColor redColor];
    }
    if (self.badgeTextColor == nil) {
        self.badgeTextColor = [UIColor whiteColor];
    }
    
    if (nil == self.badge) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            CGFloat redotWidth = 8;
            CGRect frm = CGRectMake(CGRectGetWidth(self.frame), -redotWidth, redotWidth, redotWidth);
            self.badge = [[UILabel alloc] initWithFrame:frm];
            self.badge.textAlignment = NSTextAlignmentCenter;
            self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
            self.badge.backgroundColor = self.badgeBgColor;
            self.badge.textColor = self.badgeTextColor;
            self.badge.text = @"";
            self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
            self.badge.layer.masksToBounds = YES;//very important
            self.badge.hidden = NO;
            [self addSubview:self.badge];
        });
 
    }
}


#pragma 私有方法
- (void)adjustLabelWidth:(UILabel *)label
{
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [label font];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize;
    
    if (![s respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
        
    } else {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        labelsize = [s boundingRectWithSize:size
                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName : style}
                                    context:nil].size;
    }
    CGRect frame = label.frame;
    frame.size = CGSizeMake(ceilf(labelsize.width)*3, ceilf(labelsize.height));
    [label setFrame:frame];
}

- (UILabel *)badge
{
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadge:(UILabel *)label
{
    objc_setAssociatedObject(self, &badgeLabelKey, label, OBJC_ASSOCIATION_RETAIN);
}

- (UIFont *)badgeFont
{
    id font = objc_getAssociatedObject(self, &badgeFontKey);
    return font == nil ? BadgeDefaultFont : font;
}

- (void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.font = badgeFont;
    }
}

- (UIColor *)badgeBgColor
{
    return objc_getAssociatedObject(self, &badgeBgColorKey);
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor
{
    objc_setAssociatedObject(self, &badgeBgColorKey, badgeBgColor, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.backgroundColor = badgeBgColor;
    }
}

- (UIColor *)badgeTextColor
{
    return objc_getAssociatedObject(self, &badgeTextColorKey);
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.textColor = badgeTextColor;
    }
}


- (CGRect)badgeFrame
{
    id obj = objc_getAssociatedObject(self, &badgeFrameKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 4) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        CGFloat width = [obj[@"width"] floatValue];
        CGFloat height = [obj[@"height"] floatValue];
        return  CGRectMake(x, y, width, height);
    } else
        return CGRectZero;
}

- (void)setBadgeFrame:(CGRect)badgeFrame
{
    NSDictionary *frameInfo = @{@"x" : @(badgeFrame.origin.x), @"y" : @(badgeFrame.origin.y),
                                @"width" : @(badgeFrame.size.width), @"height" : @(badgeFrame.size.height)};
    objc_setAssociatedObject(self, &badgeFrameKey, frameInfo, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.frame = badgeFrame;
    }
}

- (CGPoint)badgeCenterOffset
{
    id obj = objc_getAssociatedObject(self, &badgeCenterOffsetKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        return CGPointMake(x, y);
    } else
        return CGPointZero;
}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOff
{
    NSDictionary *cenerInfo = @{@"x" : @(badgeCenterOff.x), @"y" : @(badgeCenterOff.y)};
    objc_setAssociatedObject(self, &badgeCenterOffsetKey, cenerInfo, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + badgeCenterOff.x, badgeCenterOff.y);
    }
}


- (void)setBadgeValue:(NSInteger)badgeValue
{
   [self setAssociateValue:self withKey:&badgeValue];

    self.badge.text = [NSString stringWithFormat:@"%lu", badgeValue];
}

- (NSInteger)badgeValue
{
   NSInteger tempValue = [[self getAssociatedValueForKey:&badgeValueKey] integerValue];
    if (!tempValue) {

      tempValue  =  [self.badge.text integerValue];
    }
    return tempValue;
}

// 绘制一条线
- (CAShapeLayer *)creatLineWithColor:(UIColor *)color WithlineWidth:(CGFloat)lineWidth WithOriginalpoint:(CGPoint)oPoint WithDestinationPoint:(CGPoint)Dpoint
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = lineWidth;
    lineShape.lineCap = kCALineCapRound;;
    lineShape.strokeColor = color.CGColor;
    int x = oPoint.x; int y = oPoint.y;
    int toX = Dpoint.x; int toY = Dpoint.y;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    return lineShape;
}

- (UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma private
//- (void)setAssociateValue:(id)value withKey:(void *)key {
//    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (id)getAssociatedValueForKey:(void *)key {
//    return objc_getAssociatedObject(self, key);
//}
@end
