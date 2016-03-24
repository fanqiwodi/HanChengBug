//
//  UCarBCarSellLocationViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SellLocation) (NSString *salArea);
@interface UCarBCarSellLocationViewController : UIViewController

@property (nonatomic, copy)SellLocation salAreaBlock;

@end
