//
//  UPricesDataController.m
//  Hancheng
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UPricesDataController.h"
#import "G_77_Model.h"
#import "ReactiveCocoa.h"

@interface UPricesDataController()
@property (strong, nonatomic) NSNumber *nextPage; // 翻页
@property (copy, nonatomic) NSString *URLpath; // 接口完整地址

@end

@implementation UPricesDataController
- (instancetype)initWithG_77Model:(G_77_Model *)model
{
    if (self = [super init]) {
        [RACObserve(model, specialList) subscribeNext:^(id x) {
            self.containerModelList = x;
        }];
        // 初始化其他类型
        self.nextPage = @0;
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    // 接口关联分页
    [RACObserve(self, nextPage) subscribeNext:^(NSNumber *page) {
        NSString *path = [NSString stringWithFormat:@"/api/ucarSpecial/getSpecialGoods?startNum=%@&pageSize=", page];
        self.URLpath = path;
    }];
   
    // 接口地址变化之后，更新容器
    [RACObserve(self, URLpath) subscribeNext:^(id x) {
        NSMutableArray *tempArr = [NSMutableArray array];
        if (YES != [self.nextPage isEqualToNumber: @0]) {
            [tempArr addObjectsFromArray: self.containerModelList];
        }

        GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:self.URLpath header:@{@"Uid":[UserMangerDefaults UidGet]}];
        
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {

            G_77_Model *model = [G_77_Model modelWithJSON:request.responseBody[@"data"]];
        
            [tempArr addObjectsFromArray: model.specialList];
            
            self.containerModelList = tempArr;
            self.model = model;
            if ([self.model.isPay isEqualToNumber:@1]) {
                self.containerModelList = @[];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"重新刷新页面" object:nil userInfo:nil];
            }

  
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"错误：%lu", request.responseStatusCode);
        }];
        
    }];
}


- (void)refresh
{
  
    self.nextPage = @0;
}

- (void)loadmore
{
    self.nextPage = [NSNumber numberWithInteger:[self.nextPage integerValue] + 1];
}

@end
