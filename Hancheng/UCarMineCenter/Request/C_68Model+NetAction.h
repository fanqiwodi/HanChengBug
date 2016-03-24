//
//  C_68Model+NetAction.h
//  Hancheng
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "C_68Model.h"

@interface C_68Model (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithUid:(NSDictionary *)Uid;
@end
