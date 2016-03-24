//
//  UCarBCarInfoChooseThirdTypeMode.h
//  Hancheng
//
//  Created by Tony on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface UCarBCarInfoChooseThirdTypeMode : BaseModel

@property (nonatomic, strong)NSNumber *totalCount;
@property (nonatomic, strong)NSArray *datalist;

@end

@interface UCarBCarInfoChooseThirdTypeMode_datalist : BaseModel

@property (nonatomic, strong)NSNumber *goodsTemplateId;
@property (nonatomic, strong)NSString *guidePrice;
@property (nonatomic, strong)NSString *name;

@end
