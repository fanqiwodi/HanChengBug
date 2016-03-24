//
//  UCarBCarSourceLocationViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SellLocation)(NSString *locationString);
@interface UCarBCarSourceLocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *inPutTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (nonatomic, copy) SellLocation locationPlace;
@property (nonatomic, strong)NSString *tipString; 
@property (nonatomic, strong)NSString *placeString;
@property (nonatomic, strong)NSString *infoLabeltext;

@end
