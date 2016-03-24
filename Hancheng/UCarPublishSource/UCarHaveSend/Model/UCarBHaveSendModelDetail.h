//
//  UCarBHaveSendModelDetail.h
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarBHaveSendModelDetail_data;
@interface UCarBHaveSendModelDetail : BaseModel

@property (nonatomic, strong) UCarBHaveSendModelDetail_data *data;

@end


@interface UCarBHaveSendModelDetail_data : BaseModel

@property (nonatomic, strong) NSString *insideColorDiy;
@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSString *brightPointsId;
@property (nonatomic, strong) NSNumber *goodPrice;
@property (nonatomic, strong) NSString *salesArea;
@property (nonatomic, strong) NSString *carPlace;
@property (nonatomic, strong) NSString *outsideColor;
@property (nonatomic, strong) NSString *proceduresDiy;
@property (nonatomic, strong) NSString *brightPointsPackageId;
@property (nonatomic, strong) NSString *imgs;
@property (nonatomic, strong) NSString *salesAreaDiy;
@property (nonatomic, strong) NSString *nameDiy;
@property (nonatomic, strong) NSString *outsideColorDiy;
@property (nonatomic, strong) NSString *insideColor;
@property (nonatomic, strong) NSString *frameNum;
@property (nonatomic, strong) NSString *brightPointsPackage;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *brightPoints;
@property (nonatomic, strong) NSString *arrivePortDate;
@property (nonatomic, strong) NSString *arriveShopDate;
@property (nonatomic, strong) NSNumber *guidePrice;
@property (nonatomic, strong) NSNumber *spotsId;
@property (nonatomic, strong) NSString *proceduresName;
@property (nonatomic, strong) NSNumber *procedures;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *brightPointsDiy;
@property (nonatomic, strong) NSString *imageSMURL;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSNumber *goodsTemplateId;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *goodPriceCount;
@property (nonatomic, strong) NSString *sourceName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *spotsName;
@property (nonatomic, strong) NSNumber *carSourceCategoryId;

- (NSDictionary *)makeValueForKeys;
@end