//
//  UCarPublishChooseLogoViewController.h
//  Hancheng
//
//  Created by Tony on 16/2/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BackBrandID)(NSNumber *brandID);
@interface UCarPublishChooseLogoViewController : UIViewController
@property (nonatomic, copy) BackBrandID backBrandID;
@end
