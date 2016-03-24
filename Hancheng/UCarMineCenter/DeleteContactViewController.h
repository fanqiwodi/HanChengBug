//
//  DeleteContactViewController.h
//  Hancheng
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^IS_Delete)(BOOL is_delete, NSString *phoneNumber);
@interface DeleteContactViewController : BaseViewController
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, copy) IS_Delete is_delete;
@property (nonatomic, strong) NSString *showNumber;
@end
