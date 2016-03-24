//
//  UCarBInfoChooseTypeModel.h
//  Hancheng
//
//  Created by Tony on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarBInfoChooseTypeModel_datalist;
@class UCarBInfoChooseTypeModel_datalist_value;

@interface UCarBInfoChooseTypeModel : BaseModel

@property (nonatomic, strong)NSNumber *totalCount;
@property (nonatomic, strong)NSArray *datalist;

@end

@interface UCarBInfoChooseTypeModel_datalist : BaseModel

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray *value;

@end

@interface UCarBInfoChooseTypeModel_datalist_value : BaseModel

@property (nonatomic, strong)NSString *firstWord;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *imageURL;
@property (nonatomic, strong)NSNumber *brandId;

@end