//
//  UCarMainSearchA88Model.h
//  Hancheng
//
//  Created by Tony on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarMainSearchA88Model_datalist;
@interface UCarMainSearchA88Model : BaseModel

@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;

@end

@interface UCarMainSearchA88Model_datalist : NSObject

@property (nonatomic, strong) NSNumber *id;        // 车品 id
@property (nonatomic, strong) NSString *name;      // 车品名称
@property (nonatomic, strong) NSString *price;     // 价格
@property (nonatomic, strong) NSString *guidPrice; // 指导价格
@property (nonatomic, strong) NSString *insideColor; // 内饰颜色
@property (nonatomic, strong) NSString *outsideColor;// 外饰颜色
@property (nonatomic, strong) NSString *carSourceSpotsName; //车源类型
@property (nonatomic, strong) NSString *img;        // 图片
@property (nonatomic, strong) NSString *remark;     // 备注
@property (nonatomic, strong) NSString *datetime;   // 发布时间
@property (nonatomic, strong) NSString *arrivePortDate; // 到港时间
@property (nonatomic, strong) NSString *arriveShopDate; // 到店时间
@property (nonatomic, strong) NSString *carPlace;   // 车源所在地
@property (nonatomic, strong) NSString *proceduresName; //手续
@property (nonatomic, strong) NSString *salesAreaName;  // 销售区域
@property (nonatomic, strong) NSString *brightPointsPackageName; // 亮点包
@property (nonatomic, strong) NSString *brightPointsName;        // 亮点
@property (nonatomic, strong) NSString *brightPointsDiy;         // 亮点自定义

@end
