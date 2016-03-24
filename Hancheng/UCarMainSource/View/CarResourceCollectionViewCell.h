//
//  CarResourceCollectionViewCell.h
//  Hancheng
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarResourceModel.h"
#import "G_77_Model_isPay.h"
@interface CarResourceCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) CarResourceModelChlid2 *model;
@property (weak, nonatomic) IBOutlet UIImageView *logImg;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *hotIcon;

@property (nonatomic, strong) G_77_Model_isPay_son2 *isPayModel;


@property (nonatomic, assign) BOOL checkBlank;

@end
