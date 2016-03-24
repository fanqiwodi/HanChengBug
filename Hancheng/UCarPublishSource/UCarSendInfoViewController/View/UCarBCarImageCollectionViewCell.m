//
//  UCarBCarImageCollectionViewCell.m
//  Hancheng
//
//  Created by Tony on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarBCarImageCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation UCarBCarImageCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageCollectionViewCell.contentMode = UIViewContentModeRedraw;
    _imageCollectionViewCell.backgroundColor = [UIColor clearColor];
    _imageCollectionViewCell.clipsToBounds = NO;
}

- (void)setPhoto:(MWPhoto *)photo
{
    if (photo != nil) {
         _imageCollectionViewCell.image = [photo underlyingImage];
    }
}

@end
