//
//  CancleViewController.m
//  Hancheng
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CancleViewController.h"
#import "CancleChildViewController.h"
@interface CancleViewController ()<UITableViewDataSource, UITableViewDelegate, YYTextViewDelegate>
{

}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong)  YYTextView *text;
// 汽车订单取消

@property (nonatomic, strong) NSString *orderCancelDescribe;
@property (nonatomic, strong) NSNumber *orderCancel;


// 配件订单取消
@property (nonatomic, strong) NSNumber *orderPartsId;

@end

@implementation CancleViewController
- (IBAction)subAction:(id)sender {

    // 0 取消汽车订单
    // 1 是取消商品订单
    [self.text resignFirstResponder];
    if ([self.statu isEqualToString:@"0"]) {
        self.orderCancelDescribe.length != 0 || ![self.orderCancel isEqual:nil] ? [self cancleCar] : nil;
    }
    
    if ([self.statu isEqualToString:@"1"]) {
        self.orderCancelDescribe.length != 0 ? [self cancleParts] : nil;
    }
}

- (void)cancleCar
{
    PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:@{@"orderId":self.orderId, @"orderCancelDescribe":(self.orderCancelDescribe.length != 0 ? self.orderCancelDescribe : @""), @"orderCancel":([self.orderCancel isEqual:nil] ? self.orderCancel : [NSNumber numberWithBool:NO])} urlStr:@"/api/ucarshow/delOrder" header:@{@"Uid":[UserMangerDefaults UidGet]}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseBody[@"code"] isEqualToNumber:@0]) {
            [self showHint:@"取消成功" yOffset:-400*REM];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(YTKBaseRequest *request) {
        [self showHint:@"操作失败" yOffset:-400*REM];
    }];
}

- (void)cancleParts
{
    NSDictionary *dic = @{@"orderPartsId":self.orderId, @"orderCancelDescribe":self.orderCancelDescribe};
    NSLog(@"-%@-", dic);
    PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:@{@"orderPartsId":self.orderId, @"orderCancelDescribe":self.orderCancelDescribe} urlStr:@"/api/ucarMarket/delOrdersParts" header:@{@"Uid":[UserMangerDefaults UidGet]}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if ([request.responseBody[@"code"] isEqualToNumber:@0]) {
            [self showHint:@"取消成功" yOffset:-400*REM];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(YTKBaseRequest *request) {
        [self showHint:@"操作失败" yOffset:-400*REM];

    }];
    
}

- (void)textViewDidEndEditing:(YYTextView *)textView
{
    self.orderCancelDescribe = textView.text;
}

- (void)initView
{
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
     self.text = [YYTextView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.statu isEqualToString:@"0"]) {
        return 2;
    }
    if ([self.statu isEqualToString:@"1"]) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.statu isEqualToString:@"0"]) {
        switch (indexPath.row) {
            case 0:
                return 40;
                break;
            case 1:
                return 130;
                break;
            default:
                break;
        }
    }
    
    if ([self.statu isEqualToString:@"1"]) {
        if (indexPath.row == 0) {
            return 170;
        }
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    if ([self.statu isEqualToString:@"0"]) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"取消理由";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
                break;
            case 1:
            {
              
                [cell.contentView addSubview:self.text];
                [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.insets(UIEdgeInsetsMake(0, 20*REM, 0, 0));
                }];
                self.text.placeholderText = @"详细说明";
                self.text.placeholderFont = [UIFont systemFontOfSize:15];
                self.text.placeholderTextColor = [UIColor colorWithHexString:@"9A9A9A"];
                self.text.delegate = self;
                return cell;
             
            }
                break;
            default:
                break;
        }
    }
    
    if ([self.statu isEqualToString:@"1"]) {

        if (indexPath.row == 0) {
            [cell.contentView addSubview:self.text];
            [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 20*REM, 0, 0));
            }];
            self.text.placeholderText = @"取消理由";
            self.text.placeholderFont = [UIFont systemFontOfSize:15];
            self.text.placeholderTextColor = [UIColor colorWithHexString:@"9A9A9A"];
            self.text.delegate = self;
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.statu isEqualToString:@"0"]) {
        if (indexPath.row == 0) {
            CancleChildViewController *cancleVC= [[CancleChildViewController alloc] init];
            [self.navigationController pushViewController:cancleVC animated:YES];
         

        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    @weakify(self);
    [[RACObserve([RootInstance shareRootInstance], mutableValue)filter:^BOOL(NSString *value) {
        
        
        return value.length > 0 ? value : nil;
    }] subscribeNext:^(id x) {
        @strongify(self);
        UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        if ([self.statu isEqualToString:@"0"]) {
             cell.textLabel.text = [RootInstance shareRootInstance].rootDic[@"取消理由"];
        }
        
        self.orderCancel = [x numberValue];
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];

    self.title = @"取消订单";
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
