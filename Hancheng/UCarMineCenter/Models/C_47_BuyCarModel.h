//
//  C_47_BuyCarModel.h
//  Hancheng
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 Tony. All rights reserved.
//

#import "BaseModel.h"
@class C_47_BuyCarModel_Chlid;
@interface C_47_BuyCarModel : BaseModel
@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;
@end

@interface C_47_BuyCarModel_Chlid : BaseModel
@property (nonatomic, strong) NSString *price;           //车品价格/配件价格
@property (nonatomic, strong) NSString *earnest;         //车品定金
@property (nonatomic, strong) NSString *order_sn;        //车品订单编号/配件订单编号
@property (nonatomic, strong) NSString *maxName;         //车品订单状态/配件订单状态
@property (nonatomic, strong) NSString *goodsName;       //车品名字/配件名字
@property (nonatomic, strong) NSString *modify_datetime; //车品订单状态时间/配件订单时间
@property (nonatomic, strong) NSString *spotsName;       //车品车源
@property (nonatomic, strong) NSNumber *orderId;         //车源订单的ID(车品订单的主键)/配件订单的ID（配件订单的主键）
@property (nonatomic, strong) NSString *type;            //1-代表配件订单信息，0-代表车品订单信息
@property (nonatomic, strong) NSString *create_datetime; //订单创建时间
@end