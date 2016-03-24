//
//  UCarBCarInfoTypeModel+UCarBCarInfo.h
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoTypeModel.h"

@interface UCarBCarInfoTypeModel (UCarBCarInfo)

/**
 *  选择常用品牌列表
 *
 *  @param successBlock        successBlock description
 *  @param failBlock           failBlock description
 *  @param headerDictory       header
 *  @param carSourceCategoryId carSourceCategoryId 根据一级提示出来的
 */
+ (void)GETUCarBCarInfoType:(CompletionBlock)successBlock Failure:(FailureBlock)failBlock headerDictory:(NSDictionary *)headerDictory carSourceCategoryId:(NSString *)carSourceCategoryId;


/**
 *  入库界面的品牌筛选
 *
 *  @param uid        uid
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GETUCarGetSearchBrand:(NSString *)uid successblk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk;

@end
