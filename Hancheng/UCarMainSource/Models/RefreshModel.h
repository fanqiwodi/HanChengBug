//
//  RefreshModel.h
//  Hancheng
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class RefreshModel1;
@interface RefreshModel : BaseModel
@property (nonatomic, copy) NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;
@end

@interface RefreshModel1 : BaseModel
@property (nonatomic, copy)NSString *myId;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *imageURL;
@property (nonatomic, copy)NSString *url;
@end