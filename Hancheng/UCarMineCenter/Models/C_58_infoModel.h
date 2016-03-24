//
//  C_58_infoModel.h
//  Hancheng
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"


@interface C_58_infoModel : BaseModel

@property (nonatomic, strong)NSString *phone; //客服电话
@property (nonatomic, strong)NSString *role_id; //用户权限ID：1，汽车经纪人2，企业经销商，3，个人车源商 4，企业车源商
@property (nonatomic, strong)NSString *is_auth;
@property (nonatomic, strong)NSString *real_name;
@property (nonatomic, strong)NSString *company;

@property (nonatomic, strong)NSNumber *sellOrder;
@property (nonatomic, strong)NSNumber *buyOrder;
@property (nonatomic, strong)NSNumber *is_pay;
@property (nonatomic, strong)NSString *nickName;
@property (nonatomic, strong)NSNumber *is_push;

+ (NSNumber *)findIsPay;
@end

