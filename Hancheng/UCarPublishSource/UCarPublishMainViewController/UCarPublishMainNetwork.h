//
//  UCarPublishMainNetwork.h
//  Hancheng
//
//  Created by Tony on 16/1/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Tony哥注释就是牛, 发布所有接口都在此.
 */
@interface UCarPublishMainNetwork : NSObject

/**
 *  入库主页网络请求
 *
 *  @param status       默认传入1； 1-发布； 2-下架
 *  @param uid          用户标识 * 必填
 *  @param brandId      筛选后-品牌id 默认传入 0
 *  @param successBlock 成功返回
 *  @param failureBlk   失败返回
 */
+ (void)GETSelfGoodListStatus:(NSInteger)status userId:(NSString *)uid brandId:(NSInteger)brandId successBlk:(CompletionBlock)successBlock failureBlk:(FailureBlock)failureBlk;


/**
 *  删除入库车源
 *
 *  @param carId      车品ID
 *  @param uid        header Uid
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)DELETECarGoods:(NSNumber *)carId userId:(NSString *)uid successBlk:(CompletionBlock)successBlk failure:(FailureBlock)failureBlk;



/**
 *  入库 车源上下架
 *
 *  @param carIds     车品ID
 *  @param state      上架/下架 状态*必填 1-上； 2-下；
 *  @param uid        header Uid
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)PUTCarUpDownMarket:(NSNumber *)carIds upDownState:(NSNumber *)state UserId:(NSString *)uid successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk;




/**
 *  入库 用户车源置顶
 *
 *  @param carID      车品ID
 *  @param flag       置顶标识 默认"0" 0-取消，1-置顶
 *  @param uid        header Uid
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)PUTCarUpToTopOrBottom:(NSNumber *)carID flag:(NSString *)flag UserId:(NSString *)uid successBlk:(CompletionBlock)successBlk faliureBlk:(FailureBlock)failureBlk;


















@end
