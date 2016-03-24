//
//  UCarBCarOutSideColorModel.h
//  Hancheng
//
//  Created by Tony on 15/12/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarBCarOutSideColorModel_outColorDataList;

@interface UCarBCarOutSideColorModel : BaseModel

@property (nonatomic, strong)NSNumber *totalCount;
@property (nonatomic, strong)NSArray *datalist;

@end

@interface UCarBCarOutSideColorModel_outColorDataList : BaseModel

@property (nonatomic, strong)NSString *outColor;
@property (nonatomic, strong)NSString *inColor;

@end
