//
//  UCarConfigureOrderModel.h
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarConfigureOrderModel_datalist;
@interface UCarConfigureOrderModel : BaseModel

@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;

@end

@interface UCarConfigureOrderModel_datalist : BaseModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;

@end