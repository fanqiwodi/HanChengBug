//
//  UCarBCarDocumentModel+Add.h
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarDocumentModel.h"

@interface UCarBCarDocumentModel (Add)

+ (void)GETDocumentListwithcarSourceCategoryId:(NSString *)carSourceCategoryId success:(CompletionBlock)successBlock failure:(FailureBlock)failureBlk;

@end
