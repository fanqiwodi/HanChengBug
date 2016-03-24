//
//  UCarForgotPasswordViewController.m
//  Hancheng
//
//  Created by Tony on 15/12/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UCarForgotPasswordViewController.h"
#import "UCarFindPasswordViewController.h"


@interface UCarForgotPasswordViewController ()

@end

@implementation UCarForgotPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"找回密码";
    
    
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
        self.unUserCorRadioView.layer.cornerRadius = 20;
        self.unUserCorRadioView.layer.masksToBounds = YES;
        
        self.buttonNextStep.layer.cornerRadius = 20;
        self.buttonNextStep.layer.masksToBounds = YES;
        
        self.unUserCorRadioView.layer.borderColor = GRAYCOLOR;
        self.unUserCorRadioView.layer.borderWidth = 1;
    });

    
   
}
- (IBAction)nextStepAction:(id)sender {
    
    if (self.inPutTextField.text.length != 11) {

        [self showHint:@"请输入正确的手机号码" yOffset:-300];
        return;
    }
    
    PostWithHeaderAPI *api = [[PostWithHeaderAPI alloc] initWith:@{@"userName":self.inPutTextField.text} urlStr:D91VALIDATEUSERNAME];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSNumber *code = [request.responseJSONObject objectForKey:@"code"];
        NSLog(@"%@, %@",request.responseJSONObject,code);
        if (![code isEqualToNumber:@0]) {
            UCarFindPasswordViewController *findPasswordVC = [[UCarFindPasswordViewController alloc] initWithNibName:NSStringFromClass([UCarFindPasswordViewController class]) bundle:nil];
            findPasswordVC.inputTextFieldStrPhoneNumber = self.inPutTextField.text;
            [self.navigationController pushViewController:findPasswordVC animated:YES];
        } else {
            [self showHint:@"您尚未注册U车库" yOffset:-400*REM ];
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
    
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
