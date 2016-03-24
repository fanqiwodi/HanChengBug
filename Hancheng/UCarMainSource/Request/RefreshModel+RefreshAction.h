//
//  RefreshModel+RefreshAction.h
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RefreshModel.h"

@interface RefreshModel (RefreshAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock;
@end
