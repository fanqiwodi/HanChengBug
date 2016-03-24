//
//  UCarBCarImageCollectionViewCell.h
//  Hancheng
//
//  Created by Tony on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhoto.h"
@interface UCarBCarImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageCollectionViewCell;
@property (nonatomic, strong)MWPhoto *photo;

@end
