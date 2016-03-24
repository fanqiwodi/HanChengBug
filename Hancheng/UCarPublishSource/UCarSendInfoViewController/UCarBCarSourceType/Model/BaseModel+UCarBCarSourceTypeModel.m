//
//  BaseModel+UCarBCarSourceTypeModel.m
//  Hancheng
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel+UCarBCarSourceTypeModel.h"
#import "UCarBCarSourceTypeModel.h"
@implementation BaseModel (UCarBCarSourceTypeModel)

+ (void)GETUCarBSourceTypeNetWrokBlock:(CompletionBlock)success FailureBlock:(FailureBlock)failure header:(NSDictionary *)headerDictory
{
    GetWithHeaderAPI *api = [[GetWithHeaderAPI alloc] initWithUrl:B19GETSOURCELIST header:headerDictory];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *dateSource = [NSArray modelArrayWithClass:[UCarSendInfoModel_datalist class] json:[request.responseBody objectForKey:@"datalist"]];
        NSLog(@"----%@", request.responseBody);
        NSMutableArray *tempDataSource = [NSMutableArray array];
        NSInteger max = 0;
        for (NSInteger i = 0; i < dateSource.count; i++) {
            UCarSendInfoModel_datalist *model = [dateSource objectAtIndex:i];
            [tempDataSource addObject:model];
            max =  max > [model.carSourceCategoryId integerValue] ? max : [model.carSourceCategoryId integerValue];
        }
        NSMutableArray *blockArray = [NSMutableArray array];
        for (NSInteger i = 0; i < max; i++) {
            
            NSMutableArray *inTempArr = [NSMutableArray array];
            for (NSInteger j = 0; j < tempDataSource.count; j++) {
                 UCarSendInfoModel_datalist *model = [tempDataSource objectAtIndex:j];
                if ([model.carSourceCategoryId integerValue] == i) {
                    [inTempArr addObject:model];
                }
            }
            
            if (inTempArr.count != 0) {
                [blockArray addObject:inTempArr];
                success(blockArray);
            }
        }
        
    } failure:^(YTKBaseRequest *request) {
 
    }];
 }

@end
