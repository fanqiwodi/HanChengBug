//
//  LiftTableManager.h
//  Hancheng
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//
@class LiftTableViewCell;
#import <Foundation/Foundation.h>
#import "SelectModel.h"
typedef void(^postBlock)(id returnValue, id indexPath);
@interface LiftTableManager : NSObject<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithModel:(SelectModel *)model WithIdentif:(NSString *)str WithSuccessBlock:(postBlock)sBlock WithFailure:(FailureBlock)Fblock;

@property(nonatomic, strong)NSArray *liftCellArrl;

@end
