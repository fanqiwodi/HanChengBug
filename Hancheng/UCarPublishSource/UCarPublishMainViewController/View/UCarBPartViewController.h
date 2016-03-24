//
//  UCarBPartViewController.h
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectIndex) (NSInteger selectIndex);
@interface UCarBPartViewController : UIViewController

@property (nonatomic, assign)NSInteger segmentIndex;
@property (nonatomic, copy)SelectIndex selectIndex;

@end
