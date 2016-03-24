//
//  CarBandThirdModel.h
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class CarBandThirdModel1;
@interface CarBandThirdModel : BaseModel
@property (nonatomic, copy) NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;
@end

@interface CarBandThirdModel1 : BaseModel
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *guidPrice;
@property (nonatomic, copy) NSString *insideColor;
@property (nonatomic, copy) NSString *outsideColor;
@property (nonatomic, copy) NSString *carSourceSpotsName;
@property (nonatomic, copy) NSString *imgs;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *datetime;
@property (nonatomic, copy) NSString *arrivePortDate;
@property (nonatomic, copy) NSString *arriveShopDate;
@property (nonatomic, copy) NSString *carPlace;
@property (nonatomic, copy) NSString *proceduresName;
@property (nonatomic, copy) NSString *salesAreaName;
@property (nonatomic, copy) NSString *brightPointsPackageName;
@property (nonatomic, copy) NSString *brightPointsName;
@property (nonatomic, copy) NSString *brightPointsDiy;
@end