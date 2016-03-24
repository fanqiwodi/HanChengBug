//
//  UCarBCarOutSideColorModel+Add.h
//  Hancheng
//
//  Created by Tony on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarOutSideColorModel.h"

@interface UCarBCarOutSideColorModel (Add)


+ (void)GETOutSideColorListgoodsTemplateId:(NSString *)goodsTemplateId uid:(NSString *)header successBlock:(CompletionBlock)successBloce failure:(FailureBlock)failBlock;  /**< 外观颜色*/

+ (void)GETInSideColorListgoodsTemplateId:(NSString *)goodsTemplateId uid:(NSString *)header successBlock:(CompletionBlock)successBloce failure:(FailureBlock)failBlock;  /**< 内饰颜色*/
@end
