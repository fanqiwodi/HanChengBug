//
//  C_58_infoModel+NetAction.h
//  Hancheng
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "C_58_infoModel.h"

@interface C_58_infoModel (NetAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock;
@end
