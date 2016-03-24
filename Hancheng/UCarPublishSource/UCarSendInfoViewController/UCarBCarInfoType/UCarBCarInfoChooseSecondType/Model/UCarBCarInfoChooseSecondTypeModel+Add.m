//
//  UCarBCarInfoChooseSecondTypeModel+Add.m
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarInfoChooseSecondTypeModel+Add.h"

@implementation UCarBCarInfoChooseSecondTypeModel (Add)

+ (void)GETSecondChooseType:(NSNumber *)brandLd carSourceCategoryId:(NSString *)carSourceCategoryId success:(CompletionBlock)successBlock failure:(FailureBlock)failBlock
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B22CARINFODETAIL WithParamDic:@{@"brandId":brandLd,@"carSourceCategoryId":carSourceCategoryId}];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dataSource = [NSArray modelArrayWithClass:[UCarBCarInfoChooseSecondTypeModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        
        
        NSMutableArray *tempArrayLevel1 = [[NSMutableArray alloc] init];
        NSMutableArray *tempArrayLevel2 = [[NSMutableArray alloc] init];
        NSMutableArray *bigDataSoure = [NSMutableArray array];
        
        for (UCarBCarInfoChooseSecondTypeModel_datalist *model1 in dataSource) {
            if ([model1.level isEqualToNumber:[NSNumber numberWithInteger:1]]) {
                [tempArrayLevel1 addObject:model1];
                if (tempArrayLevel2.count > 0) {
                    [bigDataSoure addObject:tempArrayLevel2];
                    tempArrayLevel2 = [NSMutableArray array];
                }
            } else if([model1.level isEqualToNumber:[NSNumber numberWithInteger:2]]){
                
                [tempArrayLevel2 addObject:model1];
            }
            
        }
        [bigDataSoure addObject:tempArrayLevel2];
        NSArray *array = [NSArray arrayWithObjects:tempArrayLevel1,bigDataSoure, nil];
        successBlock(array);
    } failure:^(YTKBaseRequest *request) {
        
    }];
}


@end
