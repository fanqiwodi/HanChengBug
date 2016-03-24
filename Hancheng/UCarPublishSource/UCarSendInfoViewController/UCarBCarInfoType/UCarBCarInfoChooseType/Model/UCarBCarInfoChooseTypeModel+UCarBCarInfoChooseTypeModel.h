//
//  UCarBCarInfoChooseTypeModel+UCarBCarInfoChooseTypeModel.h
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseTypeModel.h"

@interface UCarBCarInfoChooseTypeModel (UCarBCarInfoChooseTypeModel)

+ (void)GETCommonCarTypeChoose:(CompletionBlock)successBlock Failure:(FailureBlock)failBlock Header:(NSString *)header carSourceCategoryId:(NSString *)carSourceCategoryId;

@end
