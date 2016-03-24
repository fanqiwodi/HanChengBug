//
//  BaseModel+UCarBCarSourceTypeModel.h
//  Hancheng
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface BaseModel (UCarBCarSourceTypeModel)

+ (void)GETUCarBSourceTypeNetWrokBlock:(CompletionBlock)success FailureBlock:(FailureBlock)failure header:(NSDictionary *)headerDictory;

@end
