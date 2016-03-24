//
//  UCarShoppingMainViewModel.h
//  Hancheng
//
//  Created by Tony on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarShoppingMainViewModel_data;
@class UCarShoppingMainViewModel_data_parentGoodsPartsCategory;
@class UCarShoppingMainViewModel_data_hotGoodsParts;
@interface UCarShoppingMainViewModel : BaseModel

@property (nonatomic, strong) UCarShoppingMainViewModel_data *data;

@end


@interface UCarShoppingMainViewModel_data : BaseModel

@property (nonatomic, strong) NSArray *hotGoodsParts;
@property (nonatomic, strong) NSArray *parentGoodsPartsCategory;

@end


@interface UCarShoppingMainViewModel_data_parentGoodsPartsCategory : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *id;

@end


@interface UCarShoppingMainViewModel_data_hotGoodsParts : BaseModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *imageSMURL;
@property (nonatomic, strong) NSString *listImg;
@property (nonatomic, strong) NSString *shopPrice1;
@property (nonatomic, strong) NSString *shopPrice;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *modifyDatetime;

@end