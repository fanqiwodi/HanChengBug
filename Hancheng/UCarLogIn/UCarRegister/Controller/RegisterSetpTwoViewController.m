//
//  RegisterSetpTwoViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RegisterSetpTwoViewController.h"
#import "RegisterStepThreeViewController.h"

@interface RegisterSetpTwoViewController ()

@end

@implementation RegisterSetpTwoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
        self.view.backgroundColor = BACKGROUNDCOLOR;
        self.title = @"注册2/3";
        self.unUseBaseView.layer.cornerRadius = self.buttonNextStep.layer.cornerRadius = 20;
        self.unUseBaseView.layer.masksToBounds = self.buttonNextStep.layer.masksToBounds = YES;
        self.unUseBaseView.layer.borderColor = GRAYCOLOR;
        self.unUseBaseView.layer.borderWidth = 1;
        
    });
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
}

- (IBAction)NextStepAction:(id)sender {
    if (self.inPutPhoneNumberTextField.text.length != 11) {
        [self showHint:@"请输入正确的手机号码" yOffset:-400*REM];
    } else {
        PostWithHeaderAPI *api = [[PostWithHeaderAPI alloc] initWith:@{@"userName":self.inPutPhoneNumberTextField.text} urlStr:D91VALIDATEUSERNAME];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSNumber *code = [request.responseJSONObject objectForKey:@"code"];
            NSLog(@"%@, %@",request.responseJSONObject,code);
            if ([code isEqualToNumber:@0]) {
                RegisterStepThreeViewController *stepThree = [[RegisterStepThreeViewController alloc] initWithNibName:NSStringFromClass([RegisterStepThreeViewController class]) bundle:nil];
                stepThree.phoneNumberString = self.inPutPhoneNumberTextField.text;
                stepThree.userIdentity = self.userIdentity;
                [self.navigationController pushViewController:stepThree animated:YES];
            } else {
                [self showHint:[request.responseJSONObject objectForKey:@"msg"] yOffset:-400*REM ];
            }
        } failure:^(YTKBaseRequest *request) {
            
        }];
    }
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
