//
//  RegisterUCarUserInfo.h
//  Hancheng
//
//  Created by Tony on 16/2/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterUCarUserInfo : NSObject

/**
 *  获取省份列表
 *
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GetChooseProvincesuccess:(CompletionBlock)successBlk faliureBlk:(FailureBlock)failureBlk;

/**
 *  获取省份下对应城市列表
 *
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GetChooseCityProvinceID:(NSNumber *)provinceID success:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk;


@end
