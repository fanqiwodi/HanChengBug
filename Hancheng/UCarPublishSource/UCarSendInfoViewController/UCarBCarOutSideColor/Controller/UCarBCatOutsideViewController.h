//
//  UCarBCatOutsideViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ViewcontrollerState)
{
    outSideColorState,
    insideColorState,
};

typedef void(^ColorString)(NSString *colorStr);

@interface UCarBCatOutsideViewController : UIViewController

@property (nonatomic, copy)ColorString blockColor;

@property (nonatomic, strong)NSNumber *goodsTemplateId;
@property (nonatomic, assign)ViewcontrollerState viewState;

@end
