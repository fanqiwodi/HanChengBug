//
//  UcarBCarConfigureModel+Add.h
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UcarBCarConfigureModel.h"

@interface UcarBCarConfigureModel (Add)

+ (void)GETBrightPackageListGoodsTemplateID:(NSString *)goodsTemplateId success:(CompletionBlock)successBlk failure:(FailureBlock)failureBlk;

+ (void)GETBrightPointsListGoodsTempLateID:(NSString *)goodsTemplateId success:(CompletionBlock)successBlk failure:(FailureBlock)failureBlk;

@end
