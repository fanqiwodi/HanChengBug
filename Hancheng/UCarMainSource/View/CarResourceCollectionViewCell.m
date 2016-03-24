//
//  CarResourceCollectionViewCell.m
//  Hancheng
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarResourceCollectionViewCell.h"
#import "YYKit.h"
@implementation CarResourceCollectionViewCell

- (void)setModel:(CarResourceModelChlid2 *)model
{
    if (_model != model) {
        _model = model;
        _nameL.text = model.name;
        NSString *urlStr = [NSString stringWithFormat:@"%@/%@", model.imageURL, model.logo];

        NSURL *url = [NSURL URLWithString:urlStr];
        [_logImg setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
        
        if ([model.isHot isEqualToString:@"1"]) {
            _hotIcon.image = [UIImage imageNamed:@"hot"];
        } else
            _hotIcon.backgroundColor = [UIColor clearColor];
        
    }
}


- (void)setIsPayModel:(G_77_Model_isPay_son2 *)isPayModel
{
    if (_isPayModel != isPayModel) {
        _isPayModel = isPayModel;
        _nameL.text = _isPayModel.name;
        NSString *urlStr = [NSString stringWithFormat:@"%@/%@", _isPayModel.imageURL, _isPayModel.logo];
         NSURL *url = [NSURL URLWithString:urlStr];
        [_logImg setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
        _hotIcon.backgroundColor = [UIColor clearColor];
    } 
}


- (void)setCheckBlank:(BOOL)checkBlank
{
    _checkBlank = checkBlank;
    

    if (_checkBlank) {

        _nameL.text = @"";
        _logImg.image = [UIImage imageNamed:@""];

    }
}

- (void)awakeFromNib {
    // Initialization code

}

@end
