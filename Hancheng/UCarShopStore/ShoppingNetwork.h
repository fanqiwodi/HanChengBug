//
//  ShoppingNetwork.h
//  Hancheng
//
//  Created by Tony on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingNetwork : BaseModel


/**
 *  主页所有数据
 *
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)GetShopMainViewData:(CompletionBlock)successBlock failure:(FailureBlock)failureBlock; /**< 主页数据*/

/**
 *  分页获取主页下方页面
 *
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 *  @param pageSize     页数
 */
+ (void)GetShopMainViewSectionData:(CompletionBlock)successBlock failure:(FailureBlock)failureBlock pageSize:(NSInteger)pageSize;


/**
 *  配件详情
 *
 *  @param partID     单品ID
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GETGoodsPartsDetailsID:(NSNumber *)partID successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk;


/**
 *  筛选接口
 *
 *  @param parentID   传入配件分类的ID（配件分类的主键）
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GETGoodsPartsCategoryChildParentID:(NSNumber *)parentID successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk;


/**
 *  筛选下的配件列表F74
 *
 *  @param params     pageSize 每页条数 categoryId 某个配件分类的ID，二级分类的ID（主键）startNum 分页起始数
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GETUCarMarkerGoodSPartsListParams:(NSDictionary *)params successBlk:(CompletionBlock)successBlk faliureBlk:(FailureBlock)failureBlk;


/**
 *  某一级分类下的配件列表F75
 *
 *  @param params     id 一级分类的ID（主键） pageSize 显示的信息数  startNum 分页起始数
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GETGoodsPartsListAllParams:(NSDictionary *)params successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk;


/**
 *  预定配件
 *
 *  @param params     goodsPartsId 配件Id
 *  @param Uid        header Uid
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)POSTUCarMarketAddOrdersPartsParams:(NSDictionary *)params HeaderUid:(NSString *)Uid successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk;

@end
