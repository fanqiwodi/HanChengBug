//
//  CarBandSecondModel+CarBandAction.h
//  Hancheng
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarBandSecondModel.h"

@interface CarBandSecondModel (CarBandAction)
/**
 *  首页车品牌二级页面
 *
 *  @param successBlock 请求成功返回
 *  @param failureBlock 请求失败返回
 *  @param myID         请求ID
 */
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock BrandId:(NSNumber *)myID;

@end
