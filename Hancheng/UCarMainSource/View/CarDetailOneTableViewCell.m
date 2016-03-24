//
//  CarDetailOneTableViewCell.m
//  Hancheng
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarDetailOneTableViewCell.h"

@implementation CarDetailOneTableViewCell

- (void)setModel:(CarbandDetailModel1 *)model
{
    if (_model != model) {
        _model = model;
        _carName.text = model.name;
        NSString *serialStr = [NSString stringWithFormat:@"编号:%@", model.productCode];
        _serialNumber.text = serialStr;
        NSString *price_timeStr = [NSString stringWithFormat:@"%@  发布时间:%@", model.guidPrice, _model.datetime];
        if (model.guidPrice.length == 0) {
            price_timeStr = [NSString stringWithFormat:@"发布时间:%@", _model.datetime];
        }
        _price_time.text = price_timeStr;
        NSString *priceStr = [NSString stringWithFormat:@"%@万元", _model.price];
        NSString *lenthP = [NSString stringWithFormat:@"%@", model.price];
        NSMutableAttributedString *priceAtribute = [[NSMutableAttributedString alloc] initWithString:priceStr];
        [priceAtribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22 ] range:NSMakeRange(0, lenthP.length)];
        NSString *prepriceStr = [NSString stringWithFormat:@"%@元", _model.earnest];
        
        NSString *lenthP2 = [NSString stringWithFormat:@"%@",model.earnest];
        NSMutableAttributedString *preAtribute = [[NSMutableAttributedString alloc] initWithString:prepriceStr];
        [preAtribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, lenthP2.length)];
        _money.attributedText = priceAtribute;
        _preMoney.attributedText = preAtribute;
        _iconImg.contentMode = UIViewContentModeScaleAspectFit;
        if (![_model.isUsecurity isEqualToNumber:@1]) {
            self.iconImg.image = [UIImage imageNamed:@""];
            
        }
        if ([_model.isGoodPrice isEqualToNumber:@1]) {
             _uSpecialImg.image = [UIImage imageNamed:@"U特价"];
            
        } else if ([_model.isGoodPrice isEqualToNumber:@0]){
             _uSpecialImg.image = [UIImage imageNamed:@""];
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
    WS(weakself);
    UIView *topLine = [UIImageView new];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentView.mas_top).with.offset(1);
        make.height.equalTo(@1);
        make.left.equalTo(weakself.contentView.mas_left);
        make.right.equalTo(weakself.contentView.mas_right);
    }];
    topLine.backgroundColor = [UIColor colorWithHexString:LINECOLOR];
    
    UIView *bottomLine = [UIImageView new];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.contentView.mas_baseline).with.offset(0.5);
        make.height.equalTo(@0.5);
        make.left.equalTo(weakself.contentView.mas_left);
        make.width.equalTo(@400);
    }];
    bottomLine.backgroundColor = [UIColor colorWithHexString:LINECOLOR];
    
   
    _leftVIew.clipsToBounds = YES;
    _leftVIew.layer.cornerRadius = 3;
    _leftVIew.layer.borderWidth = 0.7;
    _leftVIew.layer.borderColor = [UIColor colorWithHexString:LINECOLOR].CGColor;
    _leftVIew.backgroundColor = [UIColor clearColor];
    

    _rightView.clipsToBounds = YES;
    _rightView.layer.cornerRadius = 3;
    _rightView.layer.borderWidth = 0.7;
    _rightView.layer.borderColor = [UIColor colorWithHexString:LINECOLOR].CGColor;
    _rightView.backgroundColor = [UIColor clearColor];
    
}


- (void)setStatus:(NSString *)status
{
    if (status.length != 0) {
        _uSpecialImg.image = [UIImage imageNamed:@"U特价"];
    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
