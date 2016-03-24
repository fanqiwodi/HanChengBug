//
//  ChangePwdViewController.m
//  Hancheng
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "ReactiveCocoa.h"
#import "UCarLoginViewController.h"
#import "BaseNavigationViewController.h"
@interface ChangePwdViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITextField *f;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong)NSString *oldPwd;
@property (nonatomic, strong)NSString *nPwd;
@property (nonatomic, strong)NSString *confirmPwd;
@end

@implementation ChangePwdViewController



- (void)initTableView
{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.myTableView.separatorColor = [UIColor colorWithHexString:LINECOLOR];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self figureoutCell:cell index:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23*REM;
}

- (void)figureoutCell:(UITableViewCell *)cell index:(NSIndexPath *)indexPath
{
    UILabel *l = [UILabel new];
    l.font = [UIFont systemFontOfSize:15];
    l.textColor = [UIColor colorWithHexString:@"333333"];
    [cell.contentView addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(10);
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.width.equalTo(@(170*REM));
    }];
    f = [UITextField new];

    f.borderStyle = UITextBorderStyleNone;
    f.secureTextEntry = YES;
    [cell.contentView addSubview:f];
    [f mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(l.mas_centerY);
        make.left.equalTo(l.mas_right).offset(10);
        make.right.equalTo(cell.contentView.mas_right);
    }];
    f.delegate = self;
    switch (indexPath.row) {
        case 0:
        {
           l.text = @"原始密码";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"请输入原始密码"];
            str.font = [UIFont systemFontOfSize:14];
            str.color = [UIColor colorWithHexString:WORDCOLOR];
            f.attributedPlaceholder = str;
            
           f.tag = 0;
        }
            break;
        case 1:
        {
           l.text = @"新密码";
           
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"请输入6-16位数字或者字符"];
            str.font = [UIFont systemFontOfSize:14];
            str.color = [UIColor colorWithHexString:WORDCOLOR];
            f.attributedPlaceholder = str;
            f.tag = 1;

        }
            break;
        case 2:
        {
            l.text = @"确认密码";

            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"请再次输入密码"];
            str.font = [UIFont systemFontOfSize:14];
            str.color = [UIColor colorWithHexString:WORDCOLOR];
            f.attributedPlaceholder = str;
            f.tag = 2;
        }
            break;
        default:
            break;
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            self.oldPwd = textField.text;
            break;
        case 1:
            self.nPwd = textField.text;
            break;
        case 2:
            self.confirmPwd = textField.text;
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    [self initTableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];
    
    RACSignal *sig = [[RACSignal combineLatest:@[RACObserve(self, oldPwd), RACObserve(self, nPwd), RACObserve(self, confirmPwd)] reduce:^id(NSString *userOld, NSString *userN, NSString *userConfrim){
        return @(userOld.length > 0 && userN.length > 0 && [userN isEqualToString:userConfrim] && [userConfrim matchesRegex:IDENTIFYPWD options:NSRegularExpressionCaseInsensitive]);
    }]distinctUntilChanged];
    
    @weakify(self);
    self.submitButton.rac_command = [[RACCommand alloc] initWithEnabled:sig signalBlock:^RACSignal *(id input) {
        @strongify(self);
        PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:@{@"oldPassword":[self.oldPwd md5String], @"password":[self.confirmPwd md5String]} urlStr:@"/api/ucarMy/ediResetPass" header:@{@"Uid":[UserMangerDefaults UidGet]}];

        NSDictionary *d = @{@"oldPassword":[self.oldPwd md5String], @"password":[self.confirmPwd md5String]};
        NSLog(@"-%@-", d);
        
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            [self showHint:request.responseBody[@"msg"] yOffset:-400*REM];
            
            if ([request.responseBody[@"code"] isEqualToNumber:@0]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UCarLoginViewController *logVC = [[UCarLoginViewController alloc] init];
                    BaseNavigationViewController *naVC = [[BaseNavigationViewController alloc]initWithRootViewController:logVC];
                    [[UIApplication sharedApplication] keyWindow].rootViewController = naVC;
                });
            }
            
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"-错误%lu-", request.responseStatusCode);
        }];
    
        return [RACSignal empty];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

SettingBottomBar
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
