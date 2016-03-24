//
//  UCarBCarDocumentModel.h
//  Hancheng
//
//  Created by Tony on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class UCarBCarDocumentModel_dataList;

@interface UCarBCarDocumentModel : BaseModel

@property (nonatomic, strong)NSArray *datalist;
@property (nonatomic, strong)NSNumber *totalCount;

@end

@interface UCarBCarDocumentModel_dataList : BaseModel

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSNumber *valueId;

@end
