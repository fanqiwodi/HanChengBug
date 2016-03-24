//
//  CompanyViewController.m
//  Hancheng
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CompanyViewController.h"
#import "ReactiveCocoa.h"
#import "UCarCompanyEditCellTableViewCell.h"
@interface CompanyViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSDictionary *dataDic;
    UITextField *nameField;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSString *company_name;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *personal_post;
@property (nonatomic, strong)NSString *personal_company;
@end

@implementation CompanyViewController
SettingBottomBar

- (void)initTableView
{

   // 判断账号权限
    if ([self.state isEqualToString:@"企业"]) {
        dataDic = @{@"0":@[@"公司全称", @"详细地址"]};
        self.title = @"公司信息";
    }
    if ([self.state isEqualToString:@"个人"]) {
        dataDic = @{@"0":@[@"公司全称", @"详细地址"], @"1":@[@"职务"]};
        self.title = @"所属公司信息";
    }
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarCompanyEditCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"reuseCell"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];
    [self.myTableView setTableFooterView:[UIView new]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25*REM;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataDic.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *intStr = [NSString stringWithFormat:@"%lu", section];
    return [dataDic[intStr] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarCompanyEditCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    NSString *intStr = [NSString stringWithFormat:@"%lu",indexPath.section];
    cell.textLabel.font= [UIFont systemFontOfSize:15];
    cell.titleLabel.text = dataDic[intStr][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            cell.lineState = 1;
        } else {
            cell.lineState = 2;
        }
    } else {
      cell.lineState = 0;
    }
    
    cell =  [self figureoutTexField:cell];
    return cell;
}

- (UCarCompanyEditCellTableViewCell *)figureoutTexField:(UCarCompanyEditCellTableViewCell *)cell
{
    cell.inputTextField.delegate = self;

    if ([cell.titleLabel.text isEqualToString:@"公司全称"]) {
        cell.inputTextField.placeholder = @"请填写公司全称";
        if (self.inputCompNameZeroRow.length > 0) {
            cell.inputTextField.text = self.inputCompNameZeroRow;
        }
        cell.inputTextField.tag = 0;
    }
     if ([cell.titleLabel.text isEqualToString:@"详细地址"]) {
          cell.inputTextField.placeholder = @"请填写公司详细地址";
         if (self.inputAddressOneRow.length > 0) {
             cell.inputTextField.text = self.inputAddressOneRow;
         }
         cell.inputTextField.tag = 1;
     }
    if ([cell.titleLabel.text isEqualToString:@"职务"]) {
        cell.inputTextField.placeholder = @"请填写公司职务";
        if (self.inputMoreRowThree.length > 0) {
            cell.inputTextField.text = self.inputMoreRowThree;
        }
        cell.inputTextField.tag = 2;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    nameField = cell.inputTextField;
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
        {
            if ([self.state isEqualToString:@"企业"]) {
                self.company_name = textField.text;
            } else if ([self.state isEqualToString:@"个人"]) {
                self.personal_company = textField.text;
            }
        }
            break;
        case 1:
        {
            self.address = textField.text;
        }
            break;
        case 2:
        {
            self.personal_post = textField.text;
        }
            break;
 
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.company_name = self.inputCompNameZeroRow;
    self.address = self.inputAddressOneRow;
    self.personal_post = self.inputMoreRowThree;
    self.personal_company = self.inputCompNameZeroRow;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)saveButton:(UIBarButtonItem *)item
{
    [nameField resignFirstResponder];
    NSDictionary *param;
    WS(myself);
    if ([self.state isEqualToString:@"企业"]) {
       
        if (self.address.length > 0 && self.company_name.length > 0) {
       
            param = @{@"address":self.address, @"company_name":self.company_name};
            PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:param urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
            [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                [myself showHint:request.responseBody[@"msg"] yOffset:-400*REM];
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(YTKBaseRequest *request) {
                NSLog(@"错误");
            }];
        }  else {
            [self showHint:@"内容填写不完整" yOffset:-400*REM];
        }
        
    }
    if ([self.state isEqualToString:@"个人"]) {
        if (self.address.length > 0 && self.personal_company.length > 0 && self.personal_post.length > 0) {
            param = @{@"address":self.address, @"personal_company":self.personal_company, @"personal_post":self.personal_post};
            PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:param urlStr:@"/api/ucarMy/ediPersonalData" header:@{@"Uid":[UserMangerDefaults UidGet]}];
            [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                [myself showHint:request.responseBody[@"msg"] yOffset:-400*REM];
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(YTKBaseRequest *request) {
                NSLog(@"错误");
            }];
        } else {
            [self showHint:@"内容填写不完整" yOffset:-400*REM];
        }
    }
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
