//
//  UCarSendInforViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  这个类可牛逼了, 能发布还能二次编辑在发布.
 *  如果好用就是Tony写的, 不好用的话我也不知道谁写的.
 */
@interface UCarSendInforViewController : UIViewController
/**
 *  当前页面的数据DataSource数组
 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/**
 *  二次编辑的CarID
 */
@property (nonatomic, strong) NSNumber *carID;
/**
 *  页面状态 = 1表示编辑
 */
@property (nonatomic, assign) NSInteger pageState;

@end
