//
//  UCarPhoneOrderView.h
//  Hancheng
//
//  Created by Tony on 16/2/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseIndex) (NSInteger pageState);
@interface UCarPhoneOrderView : UIView

@property (nonatomic, copy) ChooseIndex pageState;
@end
