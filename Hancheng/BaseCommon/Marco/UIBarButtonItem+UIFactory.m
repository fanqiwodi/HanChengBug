//
//  UIBarButtonItem+UIFactory.m
//  Hancheng
//
//  Created by Tony on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIBarButtonItem+UIFactory.h"

@implementation UIBarButtonItem (UIFactory)

+ (UIBarButtonItem *)backItemWithTarget:(id)target action:(SEL)action
{
    return [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_toolbar_back"] target:target action:action];
}

+ (UIBarButtonItem *)closeItemWithTarget:(id)target action:(SEL)action
{
    return [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_more"] target:target action:action];
}


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    barButtonItem.tintColor = [UIColor whiteColor];
    return barButtonItem;
}


@end
