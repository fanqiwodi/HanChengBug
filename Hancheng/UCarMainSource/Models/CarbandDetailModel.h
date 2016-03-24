//
//  CarbandDetailModel.h
//  Hancheng
//
//  Created by why on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class CarbandDetailModel1;
@interface CarbandDetailModel : BaseModel
@property (nonatomic, strong) CarbandDetailModel1 *data;
@end

@interface CarbandDetailModel1 : BaseModel
@property (nonatomic, copy) NSString *proceduresName;
@property (nonatomic, copy) NSString *salesAreaName;
@property (nonatomic, copy) NSString *imgs;
@property (nonatomic, copy) NSString *imageSMURL;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *productCode;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSNumber *earnest;
@property (nonatomic, copy) NSString *arriveShopDate;
@property (nonatomic, copy) NSString *carSourceSpotsName;
@property (nonatomic, copy) NSString *guidPrice;
@property (nonatomic, copy) NSNumber *myID;
@property (nonatomic, copy) NSNumber *isUsecurity;
@property (nonatomic, copy) NSString *outsideColor;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSString *insideColor;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *carPlace;
@property (nonatomic, copy) NSString *arrivePortDate;
@property (nonatomic, copy) NSString *datetime;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *callCenter;
@property (nonatomic, copy) NSString *brightPointsPackageId;

@property (nonatomic, copy) NSString *brightPointsDiy; // 显示字
@property (nonatomic, copy) NSString *brightPointsPackageName; // 能点的
@property (nonatomic, copy) NSString *brightPointsName; // 显示字

@property (nonatomic, strong) NSNumber *isGoodPrice;

@end