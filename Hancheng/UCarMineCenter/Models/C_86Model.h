//
//  C_86Model.h
//  Hancheng
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"
@class C_86ModelChild;
@interface C_86Model : BaseModel
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *goodsPartsName;
@property (nonatomic, strong) NSString *maxName;
@property (nonatomic, strong) NSString *orderSn;
@property (nonatomic, strong) NSArray *orderStatus;
@property (nonatomic, strong) NSNumber *goodsPartsId;
@property (nonatomic, strong) NSNumber *goodsPartsOrderStatusId;
@end

@interface C_86ModelChild : BaseModel
@property (nonatomic, strong) NSString *statusName;
@property (nonatomic, strong) NSString *modifyDatetime;
@property (nonatomic, strong) NSNumber *goodsPartsOrderStatusId;

@end