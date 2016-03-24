//
//  UCarMainSearchA89Model.h
//  Hancheng
//
//  Created by Tony on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarMainSearchA89Model_data;
@interface UCarMainSearchA89Model : BaseModel

@property (nonatomic, strong) UCarMainSearchA89Model_data *data;

@end


@interface UCarMainSearchA89Model_data : BaseModel

@property (nonatomic, strong) NSString *brandName;         // 品牌名称 以‘，’分隔的字符串
@property (nonatomic, strong) NSString *carSourceSpotsName;// 车源类型 以‘，’分隔的字符串
@property (nonatomic, strong) NSString *outsideColor;      // 外饰颜色 以‘，’分隔的字符串
@property (nonatomic, strong) NSString *insideColor;       // 内饰颜色 以‘，’分隔的字符串
@property (nonatomic, strong) NSString *provinceName;      // 所在地区 以‘，’分隔的字符串
@property (nonatomic, strong) NSString *sortBy;            // 价格排序 值 ASC -从低到高 或 DESC 从高到低

@end