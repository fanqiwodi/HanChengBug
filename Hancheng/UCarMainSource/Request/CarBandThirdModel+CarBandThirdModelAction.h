//
//  CarBandThirdModel+CarBandThirdModelAction.h
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarBandThirdModel.h"

@interface CarBandThirdModel (CarBandThirdModelAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock Param:(NSMutableDictionary *)dic;


+ (void)handleSelectBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock Param:(NSMutableDictionary *)dic;


+ (void)handleFlag1Block:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock Param:(NSMutableDictionary *)dic;


+ (void)hanleAfterSelectBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock Param:(NSMutableDictionary *)dic;

@end
