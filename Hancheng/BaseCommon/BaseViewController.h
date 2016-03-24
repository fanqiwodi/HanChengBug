//
//  BaseViewController.h
//  Hancheng
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (BaseViewController *)previousController;
- (BaseViewController *)ancestorControllerWithClass:(Class)clazz;
#define SettingBottomBar \
- (void)viewWillAppear:(BOOL)animated{ \
[super viewWillAppear:animated]; \
[[self rdv_tabBarController] setTabBarHidden:YES animated:NO]; \
} \
- (void)viewWillDisappear:(BOOL)animated { \
[[self rdv_tabBarController] setTabBarHidden:NO animated:NO]; \
[super viewWillDisappear:animated]; \
}
#define SettingBottomBarImplementation SettingBottomBar
@end
