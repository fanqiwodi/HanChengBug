//
//  AboutUsViewController.m
//  Hancheng
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AboutUsViewController.h"
#import "WebViewController.h"
#import "RemitViewController.h"

@interface AboutUsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation AboutUsViewController

- (NSArray *)dataArr
{
    _dataArr == nil && (_dataArr = @[@"汉乘U车库介绍", @"汇款账号", @"汉乘U车库用户服务使用协议"]);
    return _dataArr;
}
-(void) initTableview
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithHexString:LINECOLOR];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            Class cls = NSClassFromString(@"IntroduceViewController");

        
            [self.navigationController pushViewController:cls.new animated:YES];
            
        }
            break;
        case 1:
        {
            RemitViewController *remVC = [[RemitViewController alloc] init];
            [self.navigationController pushViewController:remVC animated:YES];
        }
            break;
        case 2:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.identify = @"about";
            [self.navigationController pushViewController:web animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableview];
   
    self.title = @"关于我们";
}

SettingBottomBar


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
