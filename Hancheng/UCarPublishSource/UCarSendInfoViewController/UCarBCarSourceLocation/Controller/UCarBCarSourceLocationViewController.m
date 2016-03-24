//
//  UCarBCarSourceLocationViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarBCarSourceLocationViewController.h"
#import "UCarSendInforViewController.h"
@interface UCarBCarSourceLocationViewController ()

@end

@implementation UCarBCarSourceLocationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.tipLabel.text = self.tipString;
    self.inPutTextField.placeholder = self.placeString;
    self.inPutTextField.text = self.infoLabeltext;
    });
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo:)];
}

- (void)saveInfo:(UIBarButtonItem *)button
{
    if ([self.title isEqualToString:WARTHOUSE_CYSZD]) {
        if ([self.inPutTextField.text isEqualToString:@""]) {
            [self showHint:@"请输入自定义车源所在地" yOffset:-300];
        } else {
            self.locationPlace(self.inPutTextField.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if ([self.title isEqualToString:WARTHOUSE_PZ]) {
        if ([self.inPutTextField.text isEqualToString:@""]) {
            [self showHint:@"请输入自定义配置" yOffset:-300];
        } else {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:CENTERCONFIG object:self.inPutTextField.text];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
            }
    } else if ([self.title isEqualToString:WARTHOUSE_DDSJ]) {
        if ([self.inPutTextField.text isEqualToString:@""]) {
            [self showHint:@"请输入自定到店时间" yOffset:-300];
        } else {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:CENTERARRIVETIME object:self.inPutTextField.text];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
        }
    } else if ([self.title isEqualToString:WARTHOUSE_DGSJ]) {
        if ([self.inPutTextField.text isEqualToString:@""]) {
            [self showHint:@"请输入自定义到港时间" yOffset:-300];
        } else {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:CENTERARRIVEAIRPORT object:self.inPutTextField.text];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
        }
    } else if ([self.title isEqualToString:WARTHOUSE_CJH]) {
        if ([self.inPutTextField.text isEqualToString:@""]) {
            [self showHint:@"请输入自定义车架号" yOffset:-300];
        } else {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:CENTERFRAMENUMBER object:self.inPutTextField.text];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
        }
    } else if ([self.title isEqualToString:WARTHOUSE_XSQY]) {
        if ([self.inPutTextField.text isEqualToString:@""]) {
            [self showHint:@"请输入自定义销售区域" yOffset:-300];
        } else {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:CENTERSALAREA object:self.inPutTextField.text];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
        }
    } else if ([self.title isEqualToString:WARTHOUSE_SX]) {
        if ([self.inPutTextField.text isEqualToString:@""]) {
            [self showHint:@"请输入自定义手续信息" yOffset:-300];
        } else {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:CENTERDOCUMENT object:self.inPutTextField.text];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[UCarSendInforViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
        }
    } else {
        if ([self.inPutTextField.text isEqualToString:@""]) {
            NSString *hudTitle = [NSString stringWithFormat:@"请输入%@",self.title];
            [self showHint:hudTitle yOffset:-300];
        } else {
            if ([self.title isEqualToString:@"昵称"]) {
                if (self.inPutTextField.text != 0) {
                    PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:@{@"nickName":self.inPutTextField.text} urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
                    WS(myself);
                    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                        [myself showHint:request.responseBody[@"msg"] yOffset:-400*REM];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    } failure:^(YTKBaseRequest *request) {
                        NSLog(@"错误");
                    }];
                }

            }
        }
    }
}

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
