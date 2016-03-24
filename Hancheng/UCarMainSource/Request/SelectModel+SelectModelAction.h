//
//  SelectModel+SelectModelAction.h
//  Hancheng
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SelectModel.h"

@interface SelectModel (SelectModelAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock BrandId:(NSNumber *)myID;
@end
