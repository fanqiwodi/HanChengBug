//
//  UCarBInfoChooseViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UCarInfoChooseViewControllBlock)(NSInteger refreash);
@interface UCarBInfoChooseViewController : UIViewController

@property (nonatomic, strong)NSNumber *carSourceCategoryId;
@property (nonatomic, copy)UCarInfoChooseViewControllBlock refreash;

@end
