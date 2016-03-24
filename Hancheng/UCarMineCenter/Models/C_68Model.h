//
//  C_68Model.h
//  Hancheng
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface C_68Model : BaseModel
@property (nonatomic, strong)NSString *proStatusName;
@property (nonatomic, strong)NSString *order_sn;
@property (nonatomic, strong)NSString *modify_datetime;
@property (nonatomic, strong)NSString *goodsName;
@property (nonatomic, strong)NSNumber *orderId;
@property (nonatomic, strong)NSString *type;  // 1-代表配件订单信息，0-代表车品订单信息

@end
