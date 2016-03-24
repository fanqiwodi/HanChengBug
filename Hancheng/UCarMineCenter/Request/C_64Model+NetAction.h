//
//  C_64Model+NetAction.h
//  Hancheng
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_64Model.h"

@interface C_64Model (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithUid:(NSString *)Uid;
@end
