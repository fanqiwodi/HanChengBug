//
//  C_64Model.h
//  Hancheng
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface C_64Model : BaseModel
@property(nonatomic, strong)NSString *personal_post; // 职务
@property(nonatomic, strong)NSString *phone;         // 联系电话（多个电话以逗号分隔的字符串）
@property(nonatomic, strong)NSString *role_id;       //用户权限ID：1，汽车经纪人2，企业经销商，3，个人车源商 4，企业车源商
@property(nonatomic, strong)NSString *is_auth;       //0：未认证 1：已认证
@property(nonatomic, strong)NSString *CityName;      //城市名称
@property(nonatomic, strong)NSString *personal_identifier; //身份证
@property(nonatomic, strong)NSString *photo;          //人身份证图片或者企业营业执照图片
@property(nonatomic, strong)NSString *user_name;       //注册的手机号
@property(nonatomic, strong)NSString *company_name;    // 企业公司名称
@property(nonatomic, strong)NSString *address;         //详细地址
@property(nonatomic, strong)NSString *real_name;       //真实姓名
@property(nonatomic, strong)NSString *company_license; //营业执照
@property(nonatomic, strong)NSString *personal_company; //个人公司名称
@property (nonatomic, strong) NSString *nickName;       //用户昵称
@property (nonatomic, strong) NSString *imageURL;      // 图片地址

@end


