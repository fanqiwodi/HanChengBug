//
//  UcarBCarConfigureModel.h
//  Hancheng
//
//  Created by Tony on 15/12/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class UcarBCarConfigureModel_datalist;
@interface UcarBCarConfigureModel : BaseModel

@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;

@end


@interface UcarBCarConfigureModel_datalist : BaseModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *brightPackageName;
@property (nonatomic, strong) NSString *brightName;

@end