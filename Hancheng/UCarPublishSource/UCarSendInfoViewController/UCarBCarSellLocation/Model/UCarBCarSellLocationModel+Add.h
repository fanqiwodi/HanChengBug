//
//  UCarBCarSellLocationModel+Add.h
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarSellLocationModel.h"

@interface UCarBCarSellLocationModel (Add)

+ (void)GETSalArea:(NSString *)uid success:(CompletionBlock)successBlock failure:(FailureBlock)failureBlock;

@end
