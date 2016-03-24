//
//  UserDefaultsAndNotifictionCenter.h
//  Hancheng
//
//  Created by Tony on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UserMangerDefaults.h"

#ifndef UserDefaultsAndNotifictionCenter_h
#define UserDefaultsAndNotifictionCenter_h


/**< UserDefaults*/
#define UCARNSUSERDEFULTS(userDefaults)  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

#define COMMONCARINFO @"commonCarInfo"                  /**< 入库常用发布品牌 */
#define GETUID @"gerUserIndetity"
#define IS_LOGIN @"is_logIn"
#define USERNAME @"user_Name"
#define PASSWORD @"user_Password"

#define IS_NEWMESSAGE @"is_NewMessage"      // Bool判断是否有新消息

// 登录保存用户信息
#define UCARPHONENUMBER @"phone"
#define UCARROLE_ID @"role_id"
#define UCARIS_AUTH @"is_auth"
#define UCARBUYORDER @"buyOrder"
#define UCARSELLORDER @"sellOrder"
#define UCARNICKNAME @"nickName"
#define UCARREAL_NAME @"real_name"
#define UCARCOMPANY @"company"
#define UCARIS_PAY @"is_pay"
#define UCARIS_PUSH @"is_push"
#define UCARUSER_NAME @"user_name"
#define UCARPERSONAL_IDENTIFIER @"personal_identifier"
#define UCARCOMPANY_NAME @"company_name"
#define UCARCOMPANY_LICENSE @"company_license"
#define UCARPERSONAL_COMPANY @"personal_company"


#define CENTERLOGIN         @"NSNotificationCenter_LogIn"       /**< 登录按钮跳转 */
#define CENTERLOGOUT        @"NSNotificationCenter_LOGOUT"     // 注销
#define CENTERSHOPPINGCHOOSE @"NSNotificationCenter_Choose"  /**< 商城顶部四中养护品选择按钮*/
#define CENTERCARTYPE       @"NSNotificationCenter_CarCenter"   /**< 传递car Third Tyep Detail*/
#define CENTERCARCOLOR      @"NSNotificationCenter_CarColor"    /**< 传递内饰外饰颜色 */
#define CENTERSALAREA       @"NSNotificationCenter_SalArea"     /**< 传递销售区域 */
#define CENTERCONFIG        @"NSNotificationCenter_config"      /**< 自定义配置 */
#define CENTERARRIVETIME    @"NSNotificationCenter_ArriveTime"  /**< 到店时间 */
#define CENTERARRIVEAIRPORT @"NSNotificationCenter_ArriveAirpot"/**< 到港时间*/
#define CENTERFRAMENUMBER   @"NSNotificationCenter_FrameNumber" /**< 车架号*/
#define CENTERDOCUMENT      @"NSNotificationCenter_Document"    /**< 手续*/
#define CENTERMOREINFO      @"NSNotificationCenter_MoreInfo"    /**< 备注*/
#define CENTERDETAILBUTTON  @"NSNotificationCenter_DetailButton"/**< 配置中的配置包详情*/

#define CENTERCITYNAME      @"NSNotificationCenter_CityName"    /**< 个人资料中选择城市*/
#endif /* UserDefaultsAndNotifictionCenter_h */
