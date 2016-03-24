//
//  UCarBCarSourceTypeModel.h
//  Hancheng
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarSendInfoModel_datalist;

@interface UCarBCarSourceTypeModel : BaseModel

@property(nonatomic, strong)NSNumber *totalCount;
@property(nonatomic, strong)NSArray *datalist;
@end

@interface UCarSendInfoModel_datalist : BaseModel
@property (nonatomic, strong)NSNumber *spotsId;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *spotsName;
@property (nonatomic, copy)NSNumber *carSourceCategoryId;
@property (nonatomic, copy)NSNumber *carSourceSpotsId;
@end


