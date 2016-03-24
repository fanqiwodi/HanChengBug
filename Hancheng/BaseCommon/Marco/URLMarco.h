//
//  URLMarco.h
//  Hancheng
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#ifndef URLMarco_h
#define URLMarco_h

#import "DeleteWithHeaderAPI.h"


#pragma mark 主页
#define A10UCARMAINSOURCE           @"/api/ucarshow/getBrandList"         //A10 App主页数据
#define A11UCARGETGOODSCATEGORYLIST @"/api/ucarshow/getGoodsCategoryList" // A11 品牌一级二级分类
#define A12UCARGETGOODSLIST         @"/api/ucarshow/getGoodsList"         // A12 车品列表
#define A13UCARGETGOODS             @"/api/ucarshow/getGoods"             // A13 车品详情
#define A14UCARGETSEARCHSETLIST     @"/api/ucarshow/getSerchsetList"      // A14 筛选条件
#define A15UCARGETGOODSCOUNT        @"/api/ucarshow/getGoodsCount"        // A15 筛选数量
#define A43UCARGETGOODSSHOW         @"/api/ucarshow/getGoods"             // A43 车品分享
#define A57UCARGETCAROUSEL          @"/api/ucarshow/getCarousel"          // A57 查询轮播图
#define A71UCARSHOWADDORDER         @"/api/ucarshow/addOrder"             // A71 预定车源
#define A88UCARGETSEO               @"/api/ucarshow/getSEO"               // A88 一键查询
#define A89UCARGETKEYSEARCH         @"/api/ucarshow/geKeySearch"          // A89 一键查询筛选
#define A92UCARGETKEYCOUNT          @"/api/ucarshow/geKeyCount"           // A92 一键查询数量

#pragma mark 入库
#define B16CARPUBLISHMAIN           @"/api/ucarin/getSelfGoodsList"       // B16 用户入库车源查询
#define B17USERCARINFOREFREASH      @"/api/ucarin/getGoodsRest"           // B17 用户车源批量刷新
#define B19GETSOURCELIST            @"/api/ucarin/getSourceList"          // B19 车源列表选择查询
#define B20CARINFORQUERY            @"/api/ucarin/getBrandList"           // B20 品牌列表查询
#define B22CARINFODETAIL            @"/api/ucarin/getGoodsCategoryList"   // B22 品牌一级二级分类
#define B23CARINFOTHIRDTYPE         @"/api/ucarin/getGoodsTemplateList"   // B23 车型选择列表 GET
#define B26CARLOCATIONLIST          @"/api/ucarin/getSalesList"           // B26 销售区域选择列表
#define B27CARDOCUMENTLIST          @"/api/ucarin/getProceduresList"      // B27 手续列表
#define B30CARLIGHTSPOT             @"/api/ucarin/getBrightPointsList"    // B30 亮点
#define B33CARLIGHTSPOTBAG          @"/api/ucarin/getBrightPackageList"   // B33 亮点包 ?goodsTemplateId=
#define B34PUBLISHUPDOWNCAR         @"/api/ucarin/ediGoodsStatus"         // B34 车源上下架
#define B35CARPUBLISHINFO           @"/api/ucarin/addGoods"               // B35 新增车品
#define B36PUBLISHUPTOTOPBOTTOM     @"/api/ucarin/ediGoodsTop"            // B36 车源置顶取消置顶
#define B38GETGOODSID               @"/api/ucarin/getGoods?id="           // B38 查看汽车单品
#define B41PUBLISHDELETECAR         @"/api/ucarin/delGoods"               // B41 入库删除商品
#define B42CAREDITAGAIN             @"/api/ucarin/ediGoods"               // B42 编辑发布
#define B44UCARSHARESINGLE          @"/ucar-web/api/ucarshow/getGoods"    // B44 用户车品分享 新加
#define B45UCARSHAREMUTABLE         @"/api/ucarin/getSelfGoodsList"       // B45 用户批量分享 一次5个
#define B49CARLIGHTSPOTDETAIL       @"/api/ucarin/getBrightPackageListAll"// B49 亮点包详情
#define B50CARINSIDECOLOR           @"/api/ucarin/getInsideColorList"     // B50 车型内饰颜色
#define B51CAROUTSIDECOLOR          @"/api/ucarin/getOutsideColorList"    // B51 车型外饰颜色
#define B52USERCOMMONTTYPE          @"/api/ucarin/getUseBrand"            // B52 常用品牌
#define B53CARCOMMONTYPE            @"/api/ucarin/getUseBrandList"        // B53 常用品牌列表
#define B54ADDCOMMONTYPE            @"/api/ucarin/addUseBrand"            // B54 增加常用品牌
#define B55DELETECOMMONTYPE         @"/api/ucarin/delUseBrand"            // B55 删除常用品牌
#define B87UCARGETSEARCHTYPE        @"/api/ucarin/getSearchBrand"         // B87 品牌筛选列表
#define B93GETAUTH                  @"/api/ucarin/getAuth"                // B93 用户是否认证

#pragma mark 个人
#define C58UCARGETMYINDEX         @"/api/ucarMy/getMyIndex"               // C58 个人信息首页
#define C59UCARCHOOSEPROVINCE     @"/api/ucarMy/getChoseProvince"         // C59 省份信息查询
#define C60UCARCHOOSECITY         @"/api/ucarMy/getChoseCity"             // C60 市信息查询

#pragma mark 商城
#define F21CARSHOPPINGCENTER          @"/api/ucarMarket/getGoodsPartsCategory"      // F21 配件首页信息
#define F25CARSHOPPINGSECTIONCENTER   @"/api/ucarMarket/getGoodsPartsCategoryPage"  // F25 主页分页数据
#define F29UCARGOODSPARTSDETAILS      @"/api/ucarMarket/getGoodsPartsDetails"       // F29 配件详情
#define F73GETGOODSPARTSCATEGORYCHILD @"/api/ucarMarket/getGoodsPartsCategoryChild" // F73 筛选接口
#define F74GETGOODSPARTSLIST          @"/api/ucarMarket/getGoodsPartsList"          // F74 筛选下的配件列表
#define F75GETGOODSPARTSLISTALL       @"/api/ucarMarket/getGoodsPartsListAll"       // F75 全部筛选
#define F82UCARADDORDERSPARTS         @"/api/ucarMarket/addOrdersParts"             // F82 预定配件


#pragma mark 注册登录找回密码
#define D31CARREGISTERPHONENUMBER @"/api/ucarRegist/addRegistMember"              /**< D31验证码验证 POST*/
#define D32CARREGISTERCHOOSTTYPE  @"/api/ucarRegist/addMember"                    /**< D32初步注册  POST*/
#define D91VALIDATEUSERNAME       @"/api/ucarRegist/validateUserName"             // 用户注册验证用户名接口
//userName	String
//passWord	String 不少于6位数的密码（传入MD5加密格式的字符串，移动端加密）
//sysType	Number 安卓或者IOS用户注册（0:android 1:ios）
//roleId	Number 用户角色（1，汽车经纪人，2，企业经销商3，个人车源商，4，企业车源商）
#define E18CARLOGINCHECK          @"/api/ucarLogin/addMemberLogin"                 /** E18用户登录查询 POST*/
//userName	String 传入的用户名（电话号）
//passWord	String 用户密码（传入加密成MD5格式的字符串，APP端加密）
//sysType	Number 用户所属设备（0：安卓设备，1：苹果设备）
#define E72CARFINDPASSWORD         @"/api/ucarRegist/ediMemberPassword"            /**< E72用户找回密码 PUT*/
//userName	String 用户的手机号（账号）
//passWord	String 用户要修改的密码（传入加密成MD5格式的字符串，移动端加密）
#endif /* URLMarco_h */
