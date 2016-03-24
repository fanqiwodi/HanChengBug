//
//  ContacChlidViewController.h
//  Hancheng
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^IS_Add)(BOOL is_add, NSString *phoneNumber);
@interface ContacChlidViewController : BaseViewController
@property (nonatomic, copy) IS_Add is_add;
@property (nonatomic, strong) NSMutableArray *phoneNumberArray;
@end
