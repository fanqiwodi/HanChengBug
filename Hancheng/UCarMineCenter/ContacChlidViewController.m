//
//  ContacChlidViewController.m
//  Hancheng
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ContacChlidViewController.h"
#import "C_64Model.h"
@interface ContacChlidViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (nonatomic, strong)NSString *phoneStr;
@end

@implementation ContacChlidViewController
SettingBottomBar


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.textF.delegate = self;
    self.title = @"添加联系电话";
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.phoneStr = textField.text;
}

- (void)saveAction:(UIBarButtonItem *)item
{
    [self.textF resignFirstResponder];
    
    if (self.phoneStr.length < 1) {
        [self showHint:@"新添加的联系方式不可为空" yOffset:-400*REM];
        return;
    }
    NSMutableString *phoneAllNumber = [NSMutableString new];
    if (_phoneNumberArray.count != 0) {
        [phoneAllNumber appendString:_phoneNumberArray[0]];
        [phoneAllNumber appendString:[NSString stringWithFormat:@",%@",self.phoneStr]];
    } else {
        [phoneAllNumber appendString:self.phoneStr];
    }
    
        PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:@{@"phone":phoneAllNumber} urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request)
        {
            [self showHint:@"添加" yOffset:-400*REM];
            if ([request.responseBody[@"code"] isEqualToNumber:@0]) {
                [self showHint:@"添加成功" yOffset:-400*REM];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.is_add(YES,self.phoneStr);
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } failure:^(YTKBaseRequest *request) {
            [self showHint:@"操作失败" yOffset:-400*REM];
        }];
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
