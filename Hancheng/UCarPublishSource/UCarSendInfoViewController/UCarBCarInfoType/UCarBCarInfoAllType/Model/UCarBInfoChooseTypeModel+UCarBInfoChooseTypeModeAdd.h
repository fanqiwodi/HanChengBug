//
//  UCarBInfoChooseTypeModel+UCarBInfoChooseTypeModeAdd.h
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBInfoChooseTypeModel.h"

@interface UCarBInfoChooseTypeModel (UCarBInfoChooseTypeModeAdd)

+ (void)GETUCarBInfoChooseType:(CompletionBlock)successBlock failure:(FailureBlock)failBlock carSourceCategoryId:(NSString *)carSourceCategoryId userID:(NSString *)uid;


@end
