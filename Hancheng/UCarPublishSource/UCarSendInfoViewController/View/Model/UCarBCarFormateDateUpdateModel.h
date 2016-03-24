//
//  UCarBCarFormateDateUpdateModel.h
//  Hancheng
//
//  Created by Tony on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCarBCarFormateDateUpdateModel : NSObject

@property (nonatomic, strong) NSNumber *goodsCategoryIdLevel1; //品牌一级Id
@property (nonatomic, strong) NSNumber *goodsCategoryIdLevel2; //品牌二级Id
@property (nonatomic, strong) NSString *imgs;                  //以逗号分割的图片名称
@property (nonatomic, strong) NSString *outsideColor;          //外饰颜色*
@property (nonatomic, strong) NSString *outsideColorDiy;       //自定义外饰颜色
@property (nonatomic, strong) NSString *insideColor;           //内饰颜色*
@property (nonatomic, strong) NSString *insideColorDiy;        //自定义内饰颜色
@property (nonatomic, strong) NSNumber *brandId;               //品牌Id*
@property (nonatomic, strong) NSString *frameNum;              //车架号
@property (nonatomic, strong) NSString *carPlace;              //车源所在地
@property (nonatomic, strong) NSString *carSourceSpotsId;      //车源期货现货Id8
@property (nonatomic, strong) NSString *salesArea;             //销售区域
@property (nonatomic, strong) NSString *salesAreaDiy;          //自定义销售区域
@property (nonatomic, strong) NSNumber *procedures;            //手续Id
@property (nonatomic, strong) NSString *proceduresDiy;         //自定义手续
@property (nonatomic, strong) NSNumber *goodPriceCount;        //价格数额8
@property (nonatomic, strong) NSNumber *goodPrice;             //价格形式8
@property (nonatomic, strong) NSString *brightPoints;          //亮点     
@property (nonatomic, strong) NSString *brightPointsPackageId; //亮点包Id
@property (nonatomic, strong) NSNumber *goodsTemplateId;       //车型Id8
@property (nonatomic, strong) NSString *remark;                //备注
@property (nonatomic, strong) NSNumber *sort;                  //排序
@property (nonatomic, strong) NSString *arrivePortDate;        //到港时间
@property (nonatomic, strong) NSString *arriveShopDate;        //到店时间
@property (nonatomic, strong) NSString *nameDiy;               //自定义车型名称8
@property (nonatomic, strong) NSString *brightPointsDiy;       //亮点配置自定义
@property (nonatomic, strong) NSNumber *carSourceCategoryId;   //车源Id;8
@property (nonatomic, strong) NSNumber *guidePrice;            //指导价8

- (NSDictionary *)makeValueForKeys;

@end
