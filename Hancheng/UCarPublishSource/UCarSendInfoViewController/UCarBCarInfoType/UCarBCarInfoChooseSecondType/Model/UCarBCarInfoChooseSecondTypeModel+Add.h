//
//  UCarBCarInfoChooseSecondTypeModel+Add.h
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseSecondTypeModel.h"

@interface UCarBCarInfoChooseSecondTypeModel (Add)

+ (void)GETSecondChooseType:(NSNumber *)brandLd carSourceCategoryId:(NSString *)carSourceCategoryId success:(CompletionBlock)successBlock failure:(FailureBlock)failBlock;

@end
