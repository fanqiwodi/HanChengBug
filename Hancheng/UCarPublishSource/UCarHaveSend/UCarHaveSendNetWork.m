//
//  UCarHaveSendNetWork.m
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarHaveSendNetWork.h"
#import "UCarBHaveSendModelDetail.h"
@implementation UCarHaveSendNetWork


+ (void)GETGoodsWithID:(NSNumber *)carID headerUid:(NSString *)uid successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",B38GETGOODSID,carID] header:@{@"Uid":uid}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSLog(@"=== %@",request.responseBody);
        NSLog(@"+++  %@",request.responseJSONObject);
        UCarBHaveSendModelDetail_data *data = [UCarBHaveSendModelDetail_data modelWithDictionary:[request.responseBody objectForKey:@"data"]];
        successBlk(data);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
}
@end
