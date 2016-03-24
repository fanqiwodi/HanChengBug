//
//  UCarMainSourceCarouselA57Model.h
//  Hancheng
//
//  Created by Tony on 16/2/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"
/**
 *  轮播图Model
 */
@class UCarMainSourceCarouselA57Model_datalist;
@interface UCarMainSourceCarouselA57Model : BaseModel


@property (nonatomic, copy)   NSNumber *totalCount;
@property (nonatomic, strong) NSArray  *datalist;
@end

@interface UCarMainSourceCarouselA57Model_datalist : BaseModel
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *imageURL;
@property (nonatomic, copy)NSString *url;

@end
