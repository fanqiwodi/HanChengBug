//
//  IsPayChildViewController.h
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

/*
 付费用户的列表页面
 传入参数 brandId;
 右上角有筛选按钮，点击之后弹出筛选条件
 点击列表跳转详情页面
 
*/

#import "BaseViewController.h"

@interface IsPayChildViewController : BaseViewController
@property (nonatomic, strong) NSNumber *brandId;
@property (nonatomic, strong) NSString *titleName;
@end
