//
//  UCarBHaveSendDetailTableViewCell.h
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarBHaveSendDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numberCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *carNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *guidePriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *sendTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *stateImageView;
@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceTop;

@property (nonatomic, assign) NSInteger pageState;

@end
