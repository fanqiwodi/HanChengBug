//
//  UCarPublishMainModel.h
//  Hancheng
//
//  Created by Tony on 16/1/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UCarPublishMainModel_data;
@class UCarPublishMainModel_data_heads;
@class UCarPublishMainModel_data_bodys;

@interface UCarPublishMainModel : BaseModel

@property (nonatomic, strong) UCarPublishMainModel_data *data;

@end


@interface UCarPublishMainModel_data : BaseModel

@property (nonatomic, strong) UCarPublishMainModel_data_heads *heads;
@property (nonatomic, strong) NSArray *bodys;

@end

@interface UCarPublishMainModel_data_heads : BaseModel

@property (nonatomic, strong) NSNumber *upCount;             /**< 发布数量*/
@property (nonatomic, strong) NSNumber *downCount;           /**< 下架数量*/
@property (nonatomic, strong) NSNumber *totalCount;          /**< 结果数量 0 -无*/

@end

@interface UCarPublishMainModel_data_bodys : BaseModel

@property (nonatomic, strong) NSNumber *id;                  /**< 车品id*/
@property (nonatomic, strong) NSNumber *price;               /**< 价格*/
@property (nonatomic, strong) NSString *datetime;            /**< 发布时间*/
@property (nonatomic, strong) NSString *name;                /**< 名称*/
@property (nonatomic, strong) NSString *carSourceSpotsName;  /**< 类型*/
@property (nonatomic, strong) NSString *datalist;            /**< 返回结果集*/
@property (nonatomic, strong) NSString *guidPrice;           /**< 指导价*/
@property (nonatomic, strong) NSString *proceduresName;      /**< 手续*/
@property (nonatomic, strong) NSString *salesAreaName;       /**< 销售区域*/
@property (nonatomic, strong) NSString *imgs;                /**< 图片*/
@property (nonatomic, strong) NSString *brightPointsPackageName; /**< 亮点包*/
@property (nonatomic, strong) NSString *brightPointsName;    /**< 亮点*/
@property (nonatomic, strong) NSString *brightPointsDiy;     /**< 自定义亮点*/
@property (nonatomic, strong) NSString *arriveShopDate;      /**< 到店时间*/
@property (nonatomic, strong) NSString *arrivePortDate;      /**< 到港时间*/
@property (nonatomic, strong) NSNumber *sort;                /**< 置顶标识 0-置顶； 非0不置顶*/
@property (nonatomic, strong) NSString *carPlace;            /**< 车源所在地*/
@property (nonatomic, strong) NSString *outsideColor;        //外饰颜色
@property (nonatomic, strong) NSString *insideColor;         // 内饰颜色
@end