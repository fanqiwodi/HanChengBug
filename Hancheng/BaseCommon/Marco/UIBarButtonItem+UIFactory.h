//
//  UIBarButtonItem+UIFactory.h
//  Hancheng
//
//  Created by Tony on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (UIFactory)

+ (UIBarButtonItem *)backItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)closeItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action;


@end
