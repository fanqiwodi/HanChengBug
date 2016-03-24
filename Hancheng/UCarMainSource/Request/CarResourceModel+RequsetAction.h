//
//  CarResourceModel+RequsetAction.h
//  Hancheng
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarResourceModel.h"

@interface CarResourceModel (RequsetAction)
/**
 *  首页汽车品牌一级页面请求
 *
 *  @param successBlock 请求成功返回
 *  @param failureBlock 错误返回 msg
 */
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock;
@end
