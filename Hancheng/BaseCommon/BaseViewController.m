//
//  BaseViewController.m
//  Hancheng
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "YYKit.h"
#import "BaseNavigationViewController.h"
#import <objc/runtime.h>
@interface BaseViewController ()
@property (nonatomic, strong)UIButton *badNetworkView;
@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationBar *naviBar = self.navigationController.navigationBar;
//    UIColor *color = HEXCOLOR(0x3e444f);
    

//    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
////         清除navigationBar底部1px阴影
////        naviBar.barTintColor = color;
////        naviBar.tintColor = [UIColor whiteColor];
//    } else
//    {
////        naviBar.tintColor = color;
//    }
//    
//    naviBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20],
//                                          NSForegroundColorAttributeName: [UIColor whiteColor]};
//    naviBar.translucent = NO;
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BaseViewController *)previousController
{
    NSInteger i = [self.navigationController.viewControllers indexOfObject:self];
    if (i == 0) {
        return  nil;
    } else {
        return self.navigationController.viewControllers[i-1];
    }

}


- (BaseViewController *)ancestorControllerWithClass:(Class)clazz
{
    for (BaseViewController *viewController in self.navigationController.viewControllers) {
        if ([NSStringFromClass(viewController.class) isEqualToString:NSStringFromClass(clazz)]) {
            return viewController;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
