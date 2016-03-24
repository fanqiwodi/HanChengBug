//
//  UCarPublishMainNetwork.m
//  Hancheng
//
//  Created by Tony on 16/1/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarPublishMainNetwork.h"
#import "UCarPublishMainModel.h"


@implementation UCarPublishMainNetwork

+ (void)GETSelfGoodListStatus:(NSInteger)status userId:(NSString *)uid brandId:(NSInteger)brandId successBlk:(CompletionBlock)successBlock failureBlk:(FailureBlock)failureBlk
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B16CARPUBLISHMAIN WithParamDic:@{@"status":[NSString stringWithFormat:@"%ld",(long)status],@"brandId":[NSString stringWithFormat:@"%ld",(long)brandId]}];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if (request.responseBody!= nil) {
            UCarPublishMainModel_data *model = [UCarPublishMainModel_data modelWithDictionary:[request.responseBody objectForKey:@"data"]];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *tempDic in [model.bodys mutableCopy]) {
                UCarPublishMainModel_data_bodys *model_bodys = [UCarPublishMainModel_data_bodys modelWithDictionary:tempDic];
                [tempArray addObject:model_bodys];
            }
            NSArray *blkArray = @[model.heads.upCount,model.heads.downCount,tempArray];
            successBlock(blkArray);
        }
        
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

+ (void)DELETECarGoods:(NSNumber *)carId userId:(NSString *)uid successBlk:(CompletionBlock)successBlk failure:(FailureBlock)failureBlk
{
    DeleteWithHeaderAPI *api = [[DeleteWithHeaderAPI alloc] initDeleteWith:@{@"id":carId} header:@{@"Uid":uid} urlStr:B41PUBLISHDELETECAR];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *blkDic = request.responseBody;
        successBlk(blkDic);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
}


+ (void)PUTCarUpDownMarket:(NSNumber *)carIds upDownState:(NSNumber *)state UserId:(NSString *)uid successBlk:(CompletionBlock)successBlk failureBlk:(FailureBlock)failureBlk
{
    PutWithHeaderAPI *api = [[PutWithHeaderAPI alloc] initWith:@{@"ids":carIds,@"status":state} urlStr:B34PUBLISHUPDOWNCAR header:@{@"Uid":uid}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *blkDic = request.responseBody;
        successBlk(blkDic);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
    
}

+ (void)PUTCarUpToTopOrBottom:(NSNumber *)carID flag:(NSString *)flag UserId:(NSString *)uid successBlk:(CompletionBlock)successBlk faliureBlk:(FailureBlock)failureBlk
{
    PutWithHeaderAPI *api = [[PutWithHeaderAPI alloc] initWith:@{@"id":carID,@"flag":flag} urlStr:B36PUBLISHUPTOTOPBOTTOM header:@{@"Uid":uid}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *blkDic = request.responseBody;
        successBlk(blkDic);
    } failure:^(YTKBaseRequest *request) {
        failureBlk(request.responseBody);
    }];
    
}
@end
