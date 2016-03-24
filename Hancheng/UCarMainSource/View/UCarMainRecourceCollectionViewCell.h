//
//  UCarMainRecourceCollectionViewCell.h
//  Hancheng
//
//  Created by Tony on 16/2/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCarMainRecourceCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic  ) IBOutlet UIImageView *isHot;
@property (weak, nonatomic  ) IBOutlet UIImageView *carLogo;
@property (weak, nonatomic  ) IBOutlet UILabel     *carName;

@property (nonatomic, strong) NSString *isHotString;
@property (nonatomic, strong) NSString *carLogoString;
@property (nonatomic, strong) NSString *carNameString;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fromTopSizeNumber;
@end
