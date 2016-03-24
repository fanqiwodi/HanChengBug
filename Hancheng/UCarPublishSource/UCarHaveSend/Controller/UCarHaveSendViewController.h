//
//  UCarHaveSendViewController.h
//  Hancheng
//
//  Created by Tony on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageFromState) {
    
    PageFromStateHaveUp = 1,
    PageFromStatehaveDown,
    PageFromStateFromWhy,
    PageFromStateFromNone,
};

@interface UCarHaveSendViewController : UIViewController

@property (nonatomic, strong) NSNumber *carID;
@property (nonatomic, assign) PageFromState pageState;
@property (nonatomic, assign) BOOL is_showBottom;
@property (nonatomic, strong) NSNumber *sort;

// addNew
@property (nonatomic, strong)NSString *fromVC;
@property (nonatomic, assign) NSInteger dismissState; // 1表示显示 dissmiss
@end
