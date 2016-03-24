//
//  UCarBGetGoodsPartsListF74.h
//  Hancheng
//
//  Created by Tony on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"
@class UCarBGetGoodsPartsListF74_datalist;
@interface UCarBGetGoodsPartsListF74 : BaseModel

@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;

@end


@interface UCarBGetGoodsPartsListF74_datalist : BaseModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *imageSMURL;
@property (nonatomic, strong) NSString *listImg;
@property (nonatomic, strong) NSString *shopPrice1;
@property (nonatomic, strong) NSString *shopPrice;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *modifyDatetime;

@end
