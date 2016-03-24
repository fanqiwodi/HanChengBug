//
//  C_59_C_60_Model+C59C60_NetAction.h
//  Hancheng
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_59_C_60_Model.h"

@interface C_59_C_60_Model (C59C60_NetAction)
+ (void)handleC59WithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock;


+ (void)handleC60WithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithNumber:(NSNumber *)provinceId;
@end
