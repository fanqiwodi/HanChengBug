//
//  MarcoColor.h
//  Hancheng
//
//  Created by Tony on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#ifndef MarcoColor_h
#define MarcoColor_h


// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define navigationBarColor RGB(33, 192, 174)
#define separaterColor RGB(200, 199, 204)

//16 进制颜色
#define HEXCOLOR(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]
#define HEXACOLOR(hexValue, alphaValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:(alphaValue)]



#define BACKGROUNDCOLOR HEXCOLOR(0xf5f5f9) /**< 背景颜色 */
#define CARINFORRED HEXCOLOR(0xff5000)   /**< 入库页面已发布等处红色 */
#define CARINFORGRAY HEXCOLOR(0x7a7f88)  /**< 入库页面下架灰色 */
#define GRAYCOLOR HEXCOLOR(0xbabcc2).CGColor /**<外框线 */




#endif /* MarcoColor_h */
