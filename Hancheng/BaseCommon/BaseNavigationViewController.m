//
//  BaseNavigationViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "UIBarButtonItem+UIFactory.h"

@interface BaseNavigationViewController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationViewController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)commonInit
{
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x3e444f)] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.shadowImage = [UIImage new];
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = @{NSForegroundColorAttributeName :HEXCOLOR(0xffffff), NSFontAttributeName : [UIFont systemFontOfSize:19]};
    //大功告成
    self.navigationBar.titleTextAttributes = dict;
    self.delegate = self;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationItem.leftBarButtonItem action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    
}

- (void)handleNavigationTransition:(UIGestureRecognizer *)gesture
{
    [self _didClickBackBarButtonItem:gesture];
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.delegate = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
#pragma deploymate push "ignored-api-availability"
        // 在push的时候禁用这个手势避免push的过程中这个手势触发了pop造成问题
        self.interactivePopGestureRecognizer.enabled = NO;
#pragma deploymate pop
    }
    
    if (self.viewControllers.count == 1) {
//        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)_didClickBackBarButtonItem:(id)sender
{
    [self popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (viewController.navigationItem.leftBarButtonItem == nil && [navigationController viewControllers].count > 1) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithTarget:self action:@selector(_didClickBackBarButtonItem:)];
        viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
#pragma deploymate push "ignored-api-availability"
        // rootViewController让这个手势失效，否则会造成界面无法响应的bug。大概是iOS7系统的问题
        if ([[navigationController.viewControllers firstObject] isEqual:viewController]) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        } else {
            // 重新让这个手势继续生效
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
#pragma deploymate pop
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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
