//
//  IsPayChildTableViewCell.m
//  Hancheng
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IsPayChildTableViewCell.h"
#import "UIView+BadgedView.h"
@interface IsPayChildTableViewCell ()
{
    UIView *line;

}

@end
@implementation IsPayChildTableViewCell


- (void)layoutSubviews
{
    self.img.frame = CGRectMake(0, 0, 430*REM, H(self.contentView)-5);
    [self.gradual mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.name.frame = CGRectMake(450*REM, 30*REM, 300*REM, 40*REM);
    self.shorName.frame = CGRectMake(450*REM, 90*REM, 300*REM, 40*REM);
    [self.guide_low mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.name.mas_leading);
        make.bottom.equalTo(self.lockImgbd.mas_top).offset(-5);
       
    }];
    [self.lowPirce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.guide_low);
        make.centerY.equalTo(self.lockImgbd.mas_centerY);
        make.width.equalTo(self.name.mas_width).offset(5);
    }];
    [self.lockImgbd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.equalTo(self.contentView.mas_right);
        make.leading.equalTo(self.contentView.mas_centerX).offset(10);
    }];
}

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];
    
    self.img = [UIImageView new];
    
    [self.contentView addSubview:self.img];
    self.gradual = [UIImageView new];
    self.gradual.image = [UIImage imageNamed:@"95.png"];
   
    self.lockImgbd = [UIImageView new];
    [self.contentView addSubview:self.lockImgbd];
    [self.contentView addSubview:self.gradual];
    self.name = [UILabel new];
    self.name.textColor = [UIColor colorWithHexString:@"ff5000"];
    self.name.font = [UIFont systemFontOfSize:21];
    [self.contentView addSubview:self.name];
    self.shorName = [UILabel new];
    self.shorName.textColor = [UIColor colorWithHexString:@"666666"];
    self.shorName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shorName];
    self.guide_low = [UILabel new];
    self.guide_low.textColor = [UIColor colorWithHexString:@"999999"];
    self.guide_low.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.guide_low];
    self.lowPirce = [UILabel new];
    self.lowPirce.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.lowPirce];

   
    [self.contentView bringSubviewToFront:self.lockImgbd];
    [self.contentView bringSubviewToFront:self.lowPirce];
    
}

- (void)setModelG77:(G_77_Model_son *)modelG77
{
    if (_modelG77 != modelG77) {
        _modelG77 = modelG77;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", _modelG77.imageURL, _modelG77.lowPriceImg]];

        [self.img setImageWithURL:url placeholder:[UIImage imageNamed:@"U特价缩略图缺省"]];
        self.name.text = _modelG77.name;
        self.shorName.text = _modelG77.shortName;
        self.guide_low.text = _modelG77.guidePrice;
      
        
        line = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor colorWithHexString:@"999999"];
            [self.guide_low addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
               make.edges.insets(UIEdgeInsetsMake(5, 0, 5, 0));
             
                make.height.equalTo(@.8);
                
            }];
            view;
        });
        
      
        
        
        if ([_modelG77.isLock isEqualToNumber:@0]) {
            // 未解锁
          self.lockImgbd.image = [UIImage imageNamed:@"icon_uprice_lock_bar"];
        self.lowPirce.text = @"解锁特价 》";
        } else if ([_modelG77.isLock isEqualToNumber:@1]) {
            // 解锁
            self.lockImgbd.image = [UIImage imageNamed:@"icon_uprice_unlock_bar"];
            self.lowPirce.text = [NSString stringWithFormat:@"U特价: ￥%@万", _modelG77.lowPrice];

        }
    }
}

- (void)setModel:(G_78_Model_son *)model
{
    if (_model != model) {
        _model = model;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", _model.imageURL, _model.lowPriceImg]];

//        NSLog(@"--%@--", url);
          [self.img setImageWithURL:url placeholder:[UIImage imageNamed:@"U特价缩略图缺省"]];
        self.name.text = _model.name;
        self.shorName.text = _model.shortName;
        self.guide_low.text = _model.guidePrice;
        self.lowPirce.text = [NSString stringWithFormat:@"U特价: ￥%@万", _model.lowPrice];
        
      
        
        line = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor colorWithHexString:@"999999"];
            [self.guide_low addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(5, 0, 5, 0));
                
                make.height.equalTo(@.5);
            }];
            view;
        });
        self.lockImgbd.image = [UIImage imageNamed:@"icon_uprice_unlock_bar"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
