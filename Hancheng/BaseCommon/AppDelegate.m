//
//  AppDelegate.m
//  Hancheng
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//


#import "AppDelegate.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "YTKNetworkConfig.h"
#import "IQKeyboardManager.h"
#import "UCarMainSourceViewController.h"
#import "UCarMainViewController.h"
#import "PublishViewController.h"
#import "ShopViewController.h"
#import "UPircesViewController.h"
#import "UCarLoginViewController.h"
#import "BaseNavigationViewController.h"
#import "XGPush.h"
#import "XGSetting.h"
#define _IPHONE80_ 80000
#import "UMSocial.h"
#import "DBHelper.h"
@interface AppDelegate ()<RDVTabBarControllerDelegate>
{
    RDVTabBarController *_rdvTabbarVC;
    UIImageView *animationImg;
    FMDatabase *db;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUMShare];  //UM分享
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(logoutView) name:CENTERLOGOUT object:nil];
    [center addObserver:self selector:@selector(setupControlls) name:CENTERLOGIN object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    // 建立数据库
    db = [DBHelper getDataBase:@"systemNoti.db"];
    if ([db open]) {
        [db executeUpdate:@"CREATE TABLE SYSNOTI (Time Text PRIMARY KEY, Type Text, Content Text)"];
        
        NSLog(@"数据库创建完毕");
    }
    if ([UserMangerDefaults is_Login]) {
        [self setupControlls];
        
    } else {
        UCarLoginViewController *ucarLogInVC = [[UCarLoginViewController alloc] init];
        BaseNavigationViewController *rootViewController = [[BaseNavigationViewController alloc] initWithRootViewController:ucarLogInVC];
        self.window.rootViewController = rootViewController;
    }
    
    [self setKeyboard];
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"http://www.hanchauto.com:8082/ucar-web";
    
    // 正式地址http://123.57.233.174/
    // 测试地址http://www.hanchauto.com:8082/ucar-web
    
    [XGPush startApp:2200185889 appKey:@"IN241DRIE83L"];
    //注销之后需要再次注册前的准备
    void (^successCallback)(void) = ^(void){
        //如果变成需要注册状态
        if(![XGPush isUnRegisterStatus])
        {
            //iOS8注册push方法
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
            
            float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
            if(sysVer < 8){
                [self registerPush];
            }
            else{
                [self registerPushForIOS8];
            }
#else
            //iOS8之前注册push方法
            //注册Push服务，注册后才能收到推送
            [self registerPush];
#endif
        }
    };
    [XGPush initForReregister:successCallback];
    
    //推送反馈回调版本示例
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
        NSLog(@"[XGPush]handleLaunching's successBlock");
        UCARNSUSERDEFULTS(userDefaults)
        [userDefaults setBool:YES forKey:IS_NEWMESSAGE];
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"[XGPush]handleLaunching's errorBlock");
    };
    
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [XGPush handleLaunching:launchOptions successCallback:successBlock errorCallback:errorBlock];



    

    
    return YES;
}



- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

#pragma mark -- Animation 设置动画
- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 2) {
        CGRect boundingRect = CGRectMake(0, 0, 0.1, -0.1);
        
        CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
        orbit.keyPath = @"position";
        orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
        orbit.duration = .7f;
        orbit.additive = YES;
        orbit.repeatCount = 1;
        
        orbit.calculationMode = kCAAnimationPaced;
        orbit.rotationMode = kCAAnimationRotateAuto;
        
        
       [animationImg.layer addAnimation:orbit forKey:@"orbit"];
       
    }
    
}


#pragma mark -- ViewControllers 设置VC
- (void)setupControlls
{
    
    UCarMainSourceViewController *carResouceVC = [[UCarMainSourceViewController alloc] init];
    BaseNavigationViewController *naVC1 = [[BaseNavigationViewController alloc] initWithRootViewController:carResouceVC];
    
    UPircesViewController *pricesVC = [[UPircesViewController alloc]init];
    BaseNavigationViewController *naVC2 = [[BaseNavigationViewController alloc]initWithRootViewController:pricesVC];
    
    PublishViewController *publishVC = [[PublishViewController alloc] init];
    BaseNavigationViewController *naVC3 = [[BaseNavigationViewController alloc] initWithRootViewController:publishVC];
    
    ShopViewController *shopVC = [[ShopViewController alloc] init];
    BaseNavigationViewController *naVC4 = [[BaseNavigationViewController alloc] initWithRootViewController:shopVC];
    
    UCarMainViewController *mineVC = [[UCarMainViewController alloc] init];
    BaseNavigationViewController *naVC5 = [[BaseNavigationViewController alloc] initWithRootViewController:mineVC];
    
    _rdvTabbarVC = [[RDVTabBarController alloc] init];
    [_rdvTabbarVC setViewControllers:@[naVC1, naVC2, naVC3, naVC4, naVC5]];
    _rdvTabbarVC.delegate = self;
    [self customizeTabBarForController:_rdvTabbarVC];
    self.window.rootViewController = _rdvTabbarVC;
}

- (void)logoutView
{
    UCarLoginViewController *ucarLogInVC = [[UCarLoginViewController alloc] init];
    BaseNavigationViewController *rootViewController = [[BaseNavigationViewController alloc] initWithRootViewController:ucarLogInVC];
    self.window.rootViewController = rootViewController;
}
#pragma mark SETICON  设置图标
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    

    UIImage *finishedImage = [UIImage imageNamed:@"background_nor"];
    
    UIImage *unfinishedImage = [UIImage imageNamed:@"background_nor"];
    NSArray *tabBarItemImages = @[@"tab_cheyuan_nor", @"tab_tejia_nor", @"", @"tab_shangchang_nor", @"tab_wode_nor",];
    NSArray *selBarItemImages = @[@"tab_cheyuan_sel", @"tab_tejia_sel", @"", @"tab_shangchang_sel", @"tab_wode_sel",];
    NSArray *titleArr = @[@"车源", @"U特价", @"", @"商城", @"我的"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[selBarItemImages objectAtIndex:index]];
        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];

        item.title = titleArr[index];

        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.titlePositionAdjustment = UIOffsetMake(0, -2);
        item.imagePositionAdjustment = UIOffsetMake(0, 1);
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:12],
                                           NSForegroundColorAttributeName: [UIColor colorWithHexString:@"666666"],
                                           };
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:12],
                                         NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ff5000"],
                                         };
        if (index == 2) {
            item.itemHeight = 61;
            [item setBackgroundSelectedImage:[UIImage imageNamed:@"background_mid"] withUnselectedImage:[UIImage imageNamed:@"background_mid"]];

            animationImg = [UIImageView new];
            [item addSubview:animationImg];
            [animationImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            animationImg.image = [UIImage imageNamed:@"tab_ruku_nor"];
            animationImg.contentMode = UIViewContentModeScaleAspectFit;
            item.titlePositionAdjustment = UIOffsetMake(0, 5);
        }
        index++;
    }
    NSLog(@"%lu", index);
}

-(void)setKeyboard
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}


- (void)registerPushForIOS8{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}
- (void)registerPush{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //notification是发送推送时传入的字典信息
    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];
    
   
    
    //删除推送列表中的这一条
//    [XGPush delLocalNotification:notification];
    //[XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];
    
    //清空推送列表
    //[XGPush clearLocalNotifications];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

//注册UserNotification成功的回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //用户已经允许接收以下类型的推送
    //UIUserNotificationType allowedTypes = [notificationSettings types];
    
}

//按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]){
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    
    completionHandler();
}

#endif


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //NSString * deviceTokenStr = [XGPush registerDevice:deviceToken];
    
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
     
        NSLog(@"register successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        //失败之后的处理
        NSLog(@"register errorBlock");
    };
    
    [XGPush setAccount:[UserMangerDefaults UidGet]];
    NSLog(@"--user UID : %@ ---", [UserMangerDefaults UidGet]);
    
    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:successBlock errorCallback:errorBlock];
    
    //如果不需要回调
    //[XGPush registerDevice:deviceToken];
    
    //打印获取的deviceToken的字符串
    NSLog(@" deviceTokenStr is %@",deviceTokenStr);
}

//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"%@",str);
    
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    //推送反馈(app运行时)
    _rdvTabbarVC =  (RDVTabBarController *)application.keyWindow.rootViewController;

//    回调版本示例
    
    if ([db open]) {
        [db executeUpdate:@"INSERT INTO SYSNOTI (Time, Type, Content) VALUES (?,?,?)", userInfo[@"time"], userInfo[@"type"], userInfo[@"aps"][@"alert"]];
        NSLog(@"数据库插入完毕");
    }
        

     void (^successBlock)(void) = ^(void){
//     成功之后的处理
     NSLog(@"[XGPush]handleReceiveNotification successBlock");
         
     };
     
     void (^errorBlock)(void) = ^(void){
//     失败之后的处理
     NSLog(@"[XGPush]handleReceiveNotification errorBlock");
     };
     
     void (^completion)(void) = ^(void){
//     失败之后的处理
     NSLog(@"[xg push completion]userInfo is %@",userInfo);
     };
    
  [XGPush handleReceiveNotification:userInfo successCallback:successBlock errorCallback:errorBlock completion:completion];
    
    
    [[RootInstance shareRootInstance].rootDic setValue:@"有新的" forKey:@"信鸽推送我的信息"];
    if ([userInfo[@"type"] isEqualToString:@"5"]) {
        [[RootInstance shareRootInstance].rootDic setValue:@"有新的" forKey:@"信鸽推送交易提醒"];
    }
    _rdvTabbarVC.selectedIndex = 4;
}

#pragma mark UM分享
- (void)setUMShare
{
    [UMSocialData setAppKey:@"56a858d8e0f55a365d0034f0"];
}

@end
