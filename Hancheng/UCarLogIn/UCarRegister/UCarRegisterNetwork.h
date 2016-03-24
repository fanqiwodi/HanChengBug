//
//  UCarRegisterNetwork.h
//  Hancheng
//
//  Created by Tony on 16/1/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCarRegisterNetwork : NSObject

/**
 *  短信验证接口
 *
 *  @param params     phone identifyingCode(验证码)
 *  @param successBlk 成功返回
 *  @param failBlk    失败返回
 */
+ (void)POSTAddRegisterMember:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failuBlk:(FailureBlock)failBlk;


/**
 *  选择角色后分类注册
 *
 *  @param params     userName passWord sysType=1 roleId 用户角色（1，汽车经纪人，2，企业经销商3，个人车源商，4，企业车源商）
 *  @param successBlk 成功返回
 *  @param failBlk    失败返回
 */
+ (void)POSTAddMemberChooseType:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failuBlk:(FailureBlock)failBlk;

/**
 *  用户登录查询API
 *
 *  @param params     userName
 *  @param successBlk passWord MD5加密
 *  @param failBlk    sysType = 1
 */
+ (void)POSTAddMemberLogin:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failuBlk:(FailureBlock)failBlk;


/**
 *  找回密码
 *
 *  @param params     userName Password
 *  @param successBlk 成功返回
 *  @param failBlk    失败返回
 */
+ (void)PUTediMemberPassword:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failuBlk:(FailureBlock)failBlk;


@end
