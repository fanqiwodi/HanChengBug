//
//  SelectModel.h
//  Hancheng
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class SelectModel1, selectID_NameModel,selectModel_sourceS,selectModel_sourceS_son;

@interface SelectModel : BaseModel
@property (nonatomic, strong)SelectModel1 *data;
@end

@interface SelectModel1 : BaseModel
@property (nonatomic, strong)NSArray *outsideColor;
@property (nonatomic, strong)NSArray *sourceP;
@property (nonatomic, strong)NSArray *sourceS;
@property (nonatomic, strong)NSArray *carSourceSpotsId;
@property (nonatomic, strong)NSArray *point;
@property (nonatomic, strong)NSArray *province;
@property (nonatomic, strong)NSArray *insideColor;
@property (nonatomic, strong)NSNumber *flag;
@end

@interface selectID_NameModel : BaseModel
@property (nonatomic, copy)NSNumber *myID;
@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *guidePrice;
@property (nonatomic, copy)NSString *shortName;

@end

@interface selectModel_sourceS : BaseModel
@property (nonatomic, copy)NSString *modelYear;
@property (nonatomic, strong)NSArray *value;

//
@property (nonatomic, copy)NSNumber *myID;
@property (nonatomic, copy)NSString *guidePrice;
@property (nonatomic, copy)NSString *shortName;
@end

@interface selectModel_sourceS_son : BaseModel
@property (nonatomic, copy)NSNumber *myID;
@property (nonatomic, copy)NSNumber *guidePrice;
@property (nonatomic, copy)NSString *name;
@end
