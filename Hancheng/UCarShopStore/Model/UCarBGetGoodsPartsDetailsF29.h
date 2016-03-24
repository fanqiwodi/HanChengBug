//
//  UCarBGetGoodsPartsDetailsF29.h
//  Hancheng
//
//  Created by Tony on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"


@class UCarBGetGoodsPartsDetailsF29_data;
@interface UCarBGetGoodsPartsDetailsF29 : BaseModel

@property (nonatomic, strong) UCarBGetGoodsPartsDetailsF29_data *data;

@end


@interface UCarBGetGoodsPartsDetailsF29_data : BaseModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *detailImg;
@property (nonatomic, strong) NSString *shopPrice1;
@property (nonatomic, strong) NSString *shopPrice;
@property (nonatomic, strong) NSString *describe;
@property (nonatomic, strong) NSString *detailImgs;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageURL;

@end