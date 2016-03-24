//
//  UCarBCarColorDIYViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCarBCatOutsideViewController.h"


@interface UCarBCarColorDIYViewController : UIViewController

@property (strong, nonatomic)UITextField *inPutTextField;

@property (nonatomic, assign)NSInteger viewState;

@property (nonatomic, strong)NSString *inputText;
@property (nonatomic, strong)NSString *inputName;

@end
