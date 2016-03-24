//
//  G_78_Model.h
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface G_78_Model : BaseModel
@property (nonatomic, strong) NSArray *specialList;
@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSNumber *brandId;
@property (nonatomic, strong) NSString *brandName;
@end

@interface G_78_Model_son : BaseModel
@property (nonatomic, strong) NSNumber *myID;
@property (nonatomic, strong) NSString *lowPriceImg;
@property (nonatomic, strong) NSString *guidePrice;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *lowPrice;
@property (nonatomic, strong) NSString *imageURL;
@end