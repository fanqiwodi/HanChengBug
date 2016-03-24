//
//  UCarBPartViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarBPartViewController.h"

@interface UCarBPartViewController ()
@property (strong, nonatomic) IBOutlet UIView *partView;

@end

@implementation UCarBPartViewController
{
    __weak IBOutlet UIButton *productFilter;

    __weak IBOutlet UIButton *refreashAll;

}
- (IBAction)disMissViewControl:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)productFilterAction:(id)sender {
    self.selectIndex(0);
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)refreashAllButtonAction:(id)sender {
    self.selectIndex(1);
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.segmentIndex == 0) {
        productFilter.userInteractionEnabled = YES;
        refreashAll.userInteractionEnabled = YES;
        productFilter.alpha = 1;
        refreashAll.alpha = 1;
    } else {
        productFilter.userInteractionEnabled = NO;
        refreashAll.userInteractionEnabled = NO;
        productFilter.alpha = 0.5;
        refreashAll.alpha = 0.5;
    }
    
    self.partView.layer.cornerRadius = 5;
    self.partView.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor clearColor];
    
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
