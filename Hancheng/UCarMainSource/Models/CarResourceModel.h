//
//  CarResourceModel.h
//  Hancheng
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class CarResourceModelChlid1;
@class CarResourceModelChlid2;
@interface CarResourceModel : BaseModel
@property (nonatomic, copy) NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;

@end


@interface CarResourceModelChlid1 : BaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *value;
@end

@interface CarResourceModelChlid2 : BaseModel
@property (nonatomic, copy) NSNumber *myID;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *firstWord;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *isHot;
@property (nonatomic, copy) NSString *imageURL;
@end