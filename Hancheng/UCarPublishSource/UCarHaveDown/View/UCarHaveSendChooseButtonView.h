//
//  UCarHaveSendChooseButtonView.h
//  Hancheng
//
//  Created by Tony on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseIndex) (NSInteger pageState);

@interface UCarHaveSendChooseButtonView : UIView

@property (nonatomic, copy) ChooseIndex pageState;
@property (strong, nonatomic) IBOutlet UILabel *upToTopLabel;

@end
