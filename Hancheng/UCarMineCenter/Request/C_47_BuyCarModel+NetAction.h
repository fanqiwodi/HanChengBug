//
//  C_47_BuyCarModel+NetAction.h
//  Hancheng
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_47_BuyCarModel.h"


@interface C_47_BuyCarModel (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock WithC47orC48:(NSString *)C47orC48 WithHeader:(NSDictionary *)header;
@end
