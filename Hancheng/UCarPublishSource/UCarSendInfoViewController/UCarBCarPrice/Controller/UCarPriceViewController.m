//
//  UCarPriceViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarPriceViewController.h"


@interface UCarPriceViewController ()


@end

@implementation UCarPriceViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"报价";
    [super viewWillAppear:YES];
    
    self.corBorderView.layer.borderColor = HEXCOLOR(0xe6e8eb).CGColor;
    self.corBorderView.layer.cornerRadius = 20;
    self.corBorderView.layer.borderWidth = 1;
    self.cheapPointButton.layer.cornerRadius  = self.cheapPriceButton.layer.cornerRadius = self.addPriceButton.layer.cornerRadius = self.directPriceButton.layer.cornerRadius = 14;
    if (SCREENWIDTH == 320) {
        self.cheapPointButton.titleLabel.font  = self.cheapPriceButton.titleLabel.font = self.addPriceButton.titleLabel.font = self.directPriceButton.titleLabel.font = [UIFont systemFontOfSize:11];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self priceButtonAction:self.cheapPointButton];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo:)];
    NSString *guideString = [NSString stringWithFormat:@"厂商指导价:  %@ 万元",self.guidePriceString];
    UCarBHeaderView *header = [UCarBHeaderView instanceView:guideString];
    header.backgroundColor = [UIColor whiteColor];
    header.frame=  CGRectMake(0, 0, SCREENWIDTH, self.guidePrice.frame.size.height);
    [self.guidePrice addSubview:header];
    
}

- (void)saveInfo:(UIBarButtonItem *)button
{
    if ([self.inPutTextField.text  isEqual: @""]) {
        [self showHint:@"请输入优惠内容"];
        return;
    } else {
    self.priceBlock(self.buttonState, self.inPutTextField.text);
    [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 四种优惠Button
- (IBAction)priceButtonAction:(id)sender {
    UIButton *button = sender;
    [self unSelectButtonColor];
    if ([button.titleLabel.text isEqualToString:@"优惠点数"]) {
        [self SelectButtonColor:_cheapPointButton];
        self.buttonState = ButtonStateCheepPoint;
        self.inPutTextField.placeholder = @"请输入优惠点数";
        self.inPutTextField.text = @"";
        self.cheapPointButton.titleLabel.textColor = [UIColor whiteColor];
        self.unitLabel.text = @"点";
    } else if ([button.titleLabel.text isEqualToString:@"优惠万元"]) {
        [self SelectButtonColor:_cheapPriceButton];
        self.buttonState = ButtonStateCheepPrice;
        self.inPutTextField.placeholder = @"请输入优惠钱数";
        self.inPutTextField.text = @"";
        self.unitLabel.text = @"万元";
    } else if ([button.titleLabel.text isEqualToString:@"加价万元"]) {
        [self SelectButtonColor:_addPriceButton];
        self.buttonState = ButtonStateAddPrice;
        self.inPutTextField.placeholder = @"请输入加价钱数";
        self.inPutTextField.text = @"";
        self.unitLabel.text = @"万元";
    } else if ([button.titleLabel.text isEqualToString:@"直接报价"]) {
        [self SelectButtonColor:_directPriceButton];
        self.buttonState = ButtonStateDirectPrice;
        self.inPutTextField.placeholder = @"请直接输入价格";
        self.inPutTextField.text = @"";
        self.unitLabel.text = @"万元";
    }
}

- (void)SelectButtonColor:(UIButton *)button
{
    button.backgroundColor = CARINFORRED;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


- (void)unSelectButtonColor
{
    _cheapPointButton.titleLabel.textColor  = _cheapPriceButton.titleLabel.textColor = _addPriceButton.titleLabel.textColor = _directPriceButton.titleLabel.textColor = HEXCOLOR(0x909092);
    _cheapPointButton.backgroundColor  = _cheapPriceButton.backgroundColor = _addPriceButton.backgroundColor = _directPriceButton.backgroundColor = HEXCOLOR(0xebebf0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
