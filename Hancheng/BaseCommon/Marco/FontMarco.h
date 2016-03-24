//
//  FontMarco.h
//  Hancheng
//
//  Created by Tony on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#ifndef FontMarco_h
#define FontMarco_h

#define WIDTH self.view.frame.size.width
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT self.view.frame.size.height
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define LAYOUT_SIZE [UIScreen mainScreen].bounds.size.width / 375
#define LAYOUT_SIZE_iPhone5 [UIScreen mainScreen].bounds.size.width / 320
#define Font(x)                         [UIFont systemFontOfSize:x * LAYOUT_SIZE]
#define ItalicFont(x)                   [UIFont italicSystemFontOfSize:x]
#define BoldFont(x)                     [UIFont boldSystemFontOfSize : x]

#define WARTHOUSE_CYSZD            @"车源所在地"
#define WARTHOUSE_XSQY             @"销售区域"
#define WARTHOUSE_SX               @"手续"
#define WARTHOUSE_PZ               @"配置"
#define WARTHOUSE_DDSJ             @"到店时间"
#define WARTHOUSE_CJH              @"车架号"
#define WARTHOUSE_DGSJ             @"到港时间"
#define WARTHOUSE_IMAGE            @"图像"
#define WARTHOUSE_BZ               @"备注"
#define WARTHOUSE_CYLX             @"车源类型"
#define WARTHOUSE_DYCX             @"对应车型"
#define WARTHOUSE_CSZDJ            @"厂商指导价"
#define WARTHOUSE_BJ               @"报价"
#define WARTHOUSE_WGYS             @"外观颜色"
#define WARTHOUSE_NSYS             @"内饰颜色"


#endif /* FontMarco_h */
