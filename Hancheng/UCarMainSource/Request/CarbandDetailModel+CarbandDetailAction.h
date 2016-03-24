//
//  CarbandDetailModel+CarbandDetailAction.h
//  Hancheng
//
//  Created by why on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarbandDetailModel.h"

@interface CarbandDetailModel (CarbandDetailAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock BrandId:(NSNumber *)myID;
@end
