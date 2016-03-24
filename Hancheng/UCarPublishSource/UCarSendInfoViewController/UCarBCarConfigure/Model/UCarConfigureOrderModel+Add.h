//
//  UCarConfigureOrderModel+Add.h
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarConfigureOrderModel.h"

@interface UCarConfigureOrderModel (Add)

+(void)GETBrightPackageListAllbrightPackageId:(NSString *)brightPackageId success:(CompletionBlock)successBlk failure:(FailureBlock)falureBlk;

@end
