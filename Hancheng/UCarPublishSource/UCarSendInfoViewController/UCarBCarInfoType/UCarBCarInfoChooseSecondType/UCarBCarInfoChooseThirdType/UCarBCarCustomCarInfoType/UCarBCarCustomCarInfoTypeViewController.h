//
//  UCarBCarCustomCarInfoTypeViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarBCarCustomCarInfoTypeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *customTestField;

// 用来传值也是醉了
@property (nonatomic, strong) NSNumber *goodsCategoryIdLevel1;
@property (nonatomic, strong) NSString *goodsCategoryIdLevel2;
@property (nonatomic, strong) NSString *carSourceCategoryId;
@property (nonatomic, strong) NSNumber *brandID;

@end
