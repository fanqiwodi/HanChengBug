//
//  UCarHaveSendNetWork.h
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCarHaveSendNetWork : NSObject

/**
 *  汽车单品编辑接口
 *
 *  @param carID      车品id
 *  @param uid        header UID
 *  @param successBlk successBlk description
 *  @param failureBlk failureBlk description
 */
+ (void)GETGoodsWithID:(NSNumber *)carID headerUid:(NSString *)uid successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk;


@end
