//
//  UCarPriceViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCarBHeaderView.h"

typedef void(^blokcPrice) (NSInteger buttonState, NSString *priceNumber);

typedef NS_ENUM(NSInteger,ButtonState)
{
    ButtonStateCheepPoint = 0,
    ButtonStateCheepPrice,
    ButtonStateAddPrice,
    ButtonStateDirectPrice,
};


@interface UCarPriceViewController : UIViewController

@property (nonatomic, strong)NSString *guidePriceString;

@property (nonatomic, assign)ButtonState buttonState;
@property (nonatomic, copy)blokcPrice priceBlock;


@property (weak, nonatomic) IBOutlet UCarBHeaderView *guidePrice;
@property (weak, nonatomic) IBOutlet UIButton *cheapPointButton;
@property (weak, nonatomic) IBOutlet UIButton *cheapPriceButton;
@property (weak, nonatomic) IBOutlet UIButton *addPriceButton;
@property (weak, nonatomic) IBOutlet UIButton *directPriceButton;
@property (weak, nonatomic) IBOutlet UIView *corBorderView;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UITextField *inPutTextField;
@end
