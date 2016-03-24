//
//  G_77_Model_isPay.h
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseModel.h"
@class G_77_Model_isPay_son1;
@class G_77_Model_isPay_son2;

@interface G_77_Model_isPay : BaseModel
@property (nonatomic, strong) NSNumber *isPay;
@property (nonatomic, strong) NSArray *specialList;
@end

@interface G_77_Model_isPay_son1 : BaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *value;
@end

@interface G_77_Model_isPay_son2 : BaseModel
@property (nonatomic, copy) NSNumber *brandId;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *firstWord;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageURL;
@end