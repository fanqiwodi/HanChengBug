//
//  UCarBCarSellLocationModel.h
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"


@class UCarBCarSellLocationModel_dataList;

@interface UCarBCarSellLocationModel : BaseModel

@property (nonatomic, strong)NSArray *datalist;
@property (nonatomic, strong)NSNumber *totalCount;

@end

@interface UCarBCarSellLocationModel_dataList : BaseModel

@property (nonatomic, strong)NSString *salArea;

@end