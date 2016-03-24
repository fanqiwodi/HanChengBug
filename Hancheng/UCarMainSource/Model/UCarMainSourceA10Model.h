//
//  UCarMainSourceA10Model.h
//  Hancheng
//
//  Created by Tony on 16/2/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  品牌列表Model
 */
@class UCarMainSourceA10Model_DataList;
@class UCarMainSourceA10Model_DataList_Value;

@interface UCarMainSourceA10Model:BaseModel
@property (nonatomic, copy)   NSNumber *totalCount;
@property (nonatomic, strong) NSArray *datalist;
@end

@interface UCarMainSourceA10Model_DataList:BaseModel
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) NSArray *value;
@end

@interface UCarMainSourceA10Model_DataList_Value:BaseModel
@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *firstWord;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *isHot;
@property (nonatomic, copy) NSString *imageURL;

@end
