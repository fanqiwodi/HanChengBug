//
//  DeleteContactViewController.m
//  Hancheng
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DeleteContactViewController.h"
#import "C_64Model.h"
@interface DeleteContactViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (nonatomic, strong) NSString *editStr;
@end

@implementation DeleteContactViewController


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.phoneTextF.text = self.showNumber;
    self.title = @"编辑联系电话";
//    self.phoneTextF.userInteractionEnabled = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (IBAction)deleteAction:(id)sender {
    
    DeleteWithHeaderAPI *API = [[DeleteWithHeaderAPI alloc] initDeleteWith:@{@"phone":self.phone} header:@{@"Uid":[UserMangerDefaults UidGet]} urlStr:@"/api/ucarMy/delUserPhone"];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseBody[@"code"] isEqualToNumber:@0]) {
            [self showHint:@"删除成功" yOffset:-400*REM];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.is_delete(YES, @"");
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(YTKBaseRequest *request) {
         [self showHint:@"操作失败" yOffset:-400*REM];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.editStr = textField.text;
}

- (void)saveAction:(UIBarButtonItem *)item
{
    [self.phoneTextF resignFirstResponder];
    
    NSString *phone = self.phoneTextF.text;
    if (self.phoneTextF.text.length > 0) {
        if (self.phone.length > 2) {
            phone = [NSString stringWithFormat:@"%@,%@",self.phone, self.phoneTextF.text];
        }
        PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:@{@"phone":phone} urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            if ([request.responseBody[@"code"] isEqualToNumber:@0]) {
                [self showHint:@"修改成功" yOffset:-400*REM];
                self.is_delete(NO, self.phoneTextF.text);
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(YTKBaseRequest *request) {
            [self showHint:@"保存失败" yOffset:-400*REM];
        }];
    } else {
        [self showHint:@"请在输入联系电话后保存"];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.phoneTextF.delegate = self;
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
