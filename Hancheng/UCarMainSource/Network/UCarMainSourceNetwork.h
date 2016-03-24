//
//  UCarMainSourceNetwork.h
//  Hancheng
//
//  Created by Tony on 16/2/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCarMainSourceA10Model.h"
#import "UCarMainSourceCarouselA57Model.h"
#import "UCarMainSearchA88Model.h"
#import "UCarMainSearchA89Model.h"
#import "UCarMainSearchA92Model.h"

@interface UCarMainSourceNetwork : NSObject
/**
 *  主页A10接口品牌
 *
 *  @param successBlk successBlk description
 *  @param faliureBlk faliureBlk description
 */
+ (void)GETWithA10:(CompletionBlock)successBlk FailureBlk:(FailureBlock)failureBlk;

/**
 *  查询轮播图
 *
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GETWithA57:(CompletionBlock)successBlk FailureBlk:(FailureBlock)failureBlk;


/**
 *  A88 一键查询
 *
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 *  @param param      
 keyWord 搜索内容 *必输项;
 brandName 品牌名称 筛选列表中获取
 carSourceSpotsName	车源类型 筛选列表中获取
 outsideColor 外饰颜色 筛选列表中获取
 insideColor  内饰颜色 筛选列表中获取
 provinceName 所在地区 筛选列表中获取
 startNum	分页起始数 默认 0；
 pageSize   查询条数
 sortBy	价格排序 值 ASC -从低到高 或 DESC 从高到低
 */
+ (void)GETWithA88:(CompletionBlock)successBlk FailureBlk:(FailureBlock)failureBlk param:(NSDictionary *)param;

/**
 *  一键查询筛选
 *
 *  @param keyword    关键字
 *  @param successblk successblk description
 *  @param failureblk failureblk description
 */
+ (void)GETWithA89KeyWord:(NSString *)keyword successBlk:(CompletionBlock)successblk failureBlk:(FailureBlock)failureblk;

/**
 *  一键查询数量
 *
 *  @param keyDictory brandName品牌名称 carSourceSpotsName车源类型 outsideColor外饰颜色 insideColor内饰颜色provinceName所在地区
 *  @param successblk successblk description
 *  @param failureblk failureblk description
 */
+(void)GETWithA92keyDictory:(NSDictionary *)keyDictory successblk:(CompletionBlock)successblk failure:(FailureBlock)failureblk;

@end
