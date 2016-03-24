//
//  UCarBCarInfoChooseTypeModel.h
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"


@class UCarBCarInfoChooseTypeModel_datalist;
@class UCarBCarInfoChooseTypeModel_datalist_value;

@interface UCarBCarInfoChooseTypeModel : BaseModel

@property (nonatomic, strong)NSNumber *totalCount;
@property (nonatomic, strong)NSArray *datalist;

@end

@interface UCarBCarInfoChooseTypeModel_datalist : BaseModel

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray *value;

@end

@interface UCarBCarInfoChooseTypeModel_datalist_value : BaseModel

@property (nonatomic,strong)NSString *firstWord;
@property (nonatomic, strong)NSNumber *isUse;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSNumber *brandId;
@property (nonatomic, strong)NSString *imageURL;

@end