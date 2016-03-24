//
//  UCarTableViewSWCell.h
//  Hancheng
//
//  Created by Tony on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//


#import "SWTableViewCell.h"
#import "UCarPublishMainModel.h"

@interface UCarTableViewSWCell : SWTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *UCarTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *UCarTitleImageView;
@property (strong, nonatomic) IBOutlet UILabel *UCarDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *UCarPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *UCarPriceguideLabel;
@property (strong, nonatomic) IBOutlet UILabel *UCarTimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *UCarRightColorImage;

@property (nonatomic, strong) UCarPublishMainModel_data_bodys *model;
@property (nonatomic, strong) NSNumber *carID;
@property (nonatomic, strong) NSNumber *sort;

@property (nonatomic, assign) NSInteger pageType; // 如果==1 则表示在主页

@end
