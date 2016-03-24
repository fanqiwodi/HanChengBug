//
//  CarBandThirdModel+CarBandThirdModelAction.m
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarBandThirdModel+CarBandThirdModelAction.h"
#import "YYKit.h"
@implementation CarBandThirdModel (CarBandThirdModelAction)
+ (void)handleWithSuccessBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock Param:(NSMutableDictionary *)dic
{
    NSString *str = [NSString stringWithFormat:@"%@?goodsCategoryIdLevel2=%@&carSourceCategoryIdLevel1=%@&carSourceCategoryIdLevel2=%@&goodsTemplateId=%@&outsideColor=%@&carSourceSpotsId=%@&province=%@&insideColor=%@&point=%@&pageSize=%@", dic[@"url"],dic[@"goodsCategoryIdLevel2"],dic[@"carSourceCategoryIdLevel1"], dic[@"carSourceCategoryIdLevel2"], dic[@"goodsTemplateId"], dic[@"outsideColor"], dic[@"carSourceSpotsId"], dic[@"province"], dic[@"insideColor"], dic[@"point"], dic[@"pageSize"]];
    NSString *encoded = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"-%@-", encoded);
 
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:encoded];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        CarBandThirdModel *model = [CarBandThirdModel modelWithJSON:request.responseBody];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}

+ (void)handleSelectBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock Param:(NSMutableDictionary *)dic
{
    
    NSString *str = [NSString stringWithFormat:@"%@%@&goodsTemplateId=%@&outsideColor=%@&insideColor=%@&carSourceSpotsId=%@&province=%@&sortBy=%@", dic[@"url"], dic[@"goodsCategoryIdLevel2"],dic[@"goodsTemplateId"], dic[@"outsideColor"], dic[@"insideColor"], dic[@"carSourceSpotsId"], dic[@"province"], dic[@"sortBy"]];
    
    NSString *encoded = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   NSLog(@"-%@-", encoded);
    
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:encoded];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        CarBandThirdModel *model = [CarBandThirdModel modelWithJSON:request.responseBody];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}

+ (void)handleFlag1Block:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock Param:(NSMutableDictionary *)dic
{
   

    
    NSString *str = [NSString stringWithFormat:@"%@%@&outsideColor=%@&insideColor=%@&province=%@&sortBy=%@&point=%@&carSourceCategoryIdLevel1=%@&carSourceCategoryIdLevel2=%@&carSourceSpotsId=%@", dic[@"url"], dic[@"goodsCategoryIdLevel2"], dic[@"outsideColor"], dic[@"insideColor"], dic[@"province"], dic[@"sortBy"], dic[@"point"], dic[@"carSourceCategoryIdLevel1"], dic[@"carSourceCategoryIdLevel2"], dic[@"carSourceSpotsId"]];
    NSString *encoded = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"-%@-", encoded);
    
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:encoded];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        CarBandThirdModel *model = [CarBandThirdModel modelWithJSON:request.responseBody];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}

+ (void)hanleAfterSelectBlock:(CompletionBlock)successBlock WithFailureBlock:(FailureBlock)failureBlock Param:(NSMutableDictionary *)dic
{

    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:@"/api/ucarshow/getGoodsList?" WithParamDic:dic];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        CarBandThirdModel *model = [CarBandThirdModel modelWithJSON:request.responseBody];
        successBlock(model);
    } failure:^(YTKBaseRequest *request) {
        failureBlock(request);
    }];
}

@end
