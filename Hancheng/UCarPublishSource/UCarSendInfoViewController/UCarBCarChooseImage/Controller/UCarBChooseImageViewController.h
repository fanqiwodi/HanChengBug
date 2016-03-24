//
//  UCarBChooseImageViewController.h
//  Hancheng
//
//  Created by Tony on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageInfo) (NSMutableArray *imageArray, NSMutableArray *nameArray);

@interface UCarBChooseImageViewController : UIViewController

@property (nonatomic, copy) ImageInfo imageBlock;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *assetsArray;    // 图片数组
@property (nonatomic, strong) NSMutableArray *imageURLArray; // 上传后的网址数组
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *imageSMURL;
@property (nonatomic, assign) NSInteger pageSize;
@end
