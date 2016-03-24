//
//  UCarBCarSourceTypeViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCarBCarSourceTypeModel.h"
typedef void(^UCarBSourceType)(UCarSendInfoModel_datalist *returnModel);
@interface UCarBCarSourceTypeViewController : UIViewController

@property (nonatomic, copy)UCarBSourceType sourceTypeBlock;


@end
