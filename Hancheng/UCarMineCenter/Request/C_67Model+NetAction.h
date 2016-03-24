//
//  C_67Model+NetAction.h
//  Hancheng
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "C_67Model.h"

@interface C_67Model (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithorderId:(NSNumber *)orderId;
@end
