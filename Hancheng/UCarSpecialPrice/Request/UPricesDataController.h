//
//  UPricesDataController.h
//  Hancheng
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

/*
处理VC页面逻辑的类，主要方法有刷新，和加载。数组属性是返回装有model的数组。
 初始化方法参数：传入一个model；
 
 */
#import <Foundation/Foundation.h>
@class G_77_Model;

@interface UPricesDataController : NSObject

@property (nonatomic, copy) NSArray *containerModelList; // 请求之后返回数组的容器。

@property (nonatomic, strong) G_77_Model *model;

- (instancetype)initWithG_77Model:(G_77_Model *)model;


- (void)refresh;
- (void)loadmore;
@end
