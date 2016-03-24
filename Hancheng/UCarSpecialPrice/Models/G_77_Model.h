//
//  G_77_Model.h
//  Hancheng
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface G_77_Model : BaseModel
@property (nonatomic,strong) NSNumber *isPay;
@property (nonatomic, strong) NSArray *specialList;
@end

@interface G_77_Model_son : BaseModel
@property (nonatomic, strong) NSNumber *myID;
@property (nonatomic, strong) NSString *lowPriceImg;
@property (nonatomic, strong) NSString *guidePrice;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *lowPrice;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSNumber *isLock;
@end