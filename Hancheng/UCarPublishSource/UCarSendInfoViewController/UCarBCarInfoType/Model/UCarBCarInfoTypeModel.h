//
//  UCarBCarInfoTypeModel.h
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarBCarInfoTypeModel_datalist;

@interface UCarBCarInfoTypeModel : BaseModel

@property (nonatomic, strong)NSNumber *totalCount;
@property (nonatomic, strong)NSArray *datalist;

@end


@interface UCarBCarInfoTypeModel_datalist : BaseModel

@property (nonatomic, strong)NSString *firstWord;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSNumber *brandId;

@end