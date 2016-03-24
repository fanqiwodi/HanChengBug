//
//  AccommodaCarViewController.m
//  Hancheng
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AccommodaCarViewController.h"

@interface AccommodaCarViewController ()
@property (weak, nonatomic) IBOutlet UILabel *carName;
@property (weak, nonatomic) IBOutlet UILabel *carKind;
@property (weak, nonatomic) IBOutlet UILabel *doneMoeny;
@property (weak, nonatomic) IBOutlet UILabel *orderMoney;

@end

@implementation AccommodaCarViewController
- (IBAction)buyAction:(id)sender {
    PostWithHeaderAPI *API = [[PostWithHeaderAPI alloc] initWith:@{@"goodsId":self.model.data.myID} urlStr:@"/api/ucarshow/addOrder" header:@{@"Uid":[UserMangerDefaults UidGet]}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseBody[@"code"] isEqualToNumber:@0]) {
            [self showHint:@"购买成功" yOffset:-400*REM];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    } failure:^(YTKBaseRequest *request) {
        
    }];
    
}

- (void)initView
{
    self.carName.text = self.model.data.name;
    NSString *tagStr = [NSString stringWithFormat:@"[%@]%@/%@", self.model.data.carSourceSpotsName, self.model.data.outsideColor, self.model.data.insideColor];
    self.carKind.text = tagStr;
    self.doneMoeny.text = [NSString stringWithFormat:@"成交价:%@万元", self.model.data.price];
    self.orderMoney.text = [NSString stringWithFormat:@"%@元", self.model.data.earnest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.title = @"确认购买";
    // Do any additional setup after loading the view.

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
