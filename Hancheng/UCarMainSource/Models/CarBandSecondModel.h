//
//  CarBandSecondModel.h
//  Hancheng
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class CarBandSecondModel1;
@interface CarBandSecondModel : BaseModel

@property (nonatomic, copy)NSNumber *totalCount;
@property (nonatomic, copy)NSArray *datalist;
@end

@interface CarBandSecondModel1 : BaseModel
@property (nonatomic, copy)NSNumber *myID;
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSMutableArray *sonArr;
@end