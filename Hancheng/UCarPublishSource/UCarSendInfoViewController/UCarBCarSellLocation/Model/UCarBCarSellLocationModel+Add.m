//
//  UCarBCarSellLocationModel+Add.m
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarSellLocationModel+Add.h"

@implementation UCarBCarSellLocationModel (Add)



+ (void)GETSalArea:(NSString *)uid success:(CompletionBlock)successBlock failure:(FailureBlock)failureBlock
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B26CARLOCATIONLIST header:@{@"Uid":uid}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarBCarSellLocationModel_dataList class] json:[request.responseBody objectForKey:@"datalist"]];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (UCarBCarSellLocationModel_dataList *model in dataSource) {
            [tempArr addObject:model.salArea];
        }
        NSLog(@"%@",[tempArr lastObject]);
        successBlock(tempArr);
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


@end
