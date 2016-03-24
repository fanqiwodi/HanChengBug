//
//  RootInstance.h
//  Hancheng
//
//  Created by apple on 15/12/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootInstance : NSObject
@property (nonatomic, strong)id mutableValue;
@property (nonatomic, strong)NSMutableDictionary *rootDic;

+(RootInstance *)shareRootInstance;

-(void)removeValueforKey:(NSString *)key;

@end
