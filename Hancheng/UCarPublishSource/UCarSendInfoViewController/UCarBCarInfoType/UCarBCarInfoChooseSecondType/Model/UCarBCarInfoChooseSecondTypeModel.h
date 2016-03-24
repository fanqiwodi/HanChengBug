//
//  UCarBCarInfoChooseSecondTypeModel.h
//  Hancheng
//
//  Created by Tony on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarBCarInfoChooseSecondTypeModel_datalist;
@interface UCarBCarInfoChooseSecondTypeModel : BaseModel

@property (nonatomic, strong)NSArray *datalist;

@end

@interface UCarBCarInfoChooseSecondTypeModel_datalist : BaseModel

@property (nonatomic, strong)NSNumber *goodsCategoryIdLevel1;
@property (nonatomic, strong)NSNumber *goodsCategoryIdLevel2;
@property (nonatomic, strong)NSNumber *level;
@property (nonatomic, strong)NSString *name;

@end