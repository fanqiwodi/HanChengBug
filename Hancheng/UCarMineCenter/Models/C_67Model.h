//
//  C_67Model.h
//  Hancheng
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"
@class C_67ModelChild;
@interface C_67Model : BaseModel
@property(nonatomic, strong)NSString *price;
@property(nonatomic, strong)NSString *earnest;
@property(nonatomic, strong)NSString *order_sn;
@property(nonatomic, strong)NSString *maxName;
@property(nonatomic, strong)NSString *goodsName;
@property(nonatomic, strong)NSString *spotsName;
@property(nonatomic, strong)NSNumber *goodsId;
@property(nonatomic, strong)NSArray *orderStatus;
@end

@interface C_67ModelChild : BaseModel
@property(nonatomic, strong)NSString *statusName;
@property(nonatomic, strong)NSString *modify_datetime;
@property(nonatomic, strong) NSNumber *orderStatusId;
@end