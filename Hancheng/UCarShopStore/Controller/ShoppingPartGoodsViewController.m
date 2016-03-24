//
//  ShoppingPartGoodsViewController.m
//  Hancheng
//
//  Created by Tony on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingPartGoodsViewController.h"
#import "UCarShoppingChooseOrderTableViewCell.h"
#import "ShoppingNetwork.h"


@interface ShoppingPartGoodsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableViewChooseType;
@property (nonatomic, strong) NSArray *dataSource;
@end


static NSString *const reuseCell = @"UCarShoppingChooseOrderTableViewCell";

@implementation ShoppingPartGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNetwork];
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.5;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC)];
    [blackView addGestureRecognizer:tapGesture];
    [self.view addSubview:blackView];
}

- (void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"保存数组" object:nil userInfo:nil];
    }];
}

- (void)configNetwork
{
    
    if ([self.statuStr isEqualToString:@"UcarSpecial"]) {
        NSString *url = [NSString stringWithFormat:@"/api/ucarSpecial/getChoseList?brandId=%@", self.partID];
        GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc] initWithUrl:url header:@{@"Uid": [UserMangerDefaults UidGet]}];
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSDictionary *blkDic = request.responseBody;
            self.dataSource = [blkDic objectForKey:@"datalist"];
            [self autoLayout];
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"%lu", request.responseStatusCode);
        }];
        
    } else {
        
        [ShoppingNetwork GETGoodsPartsCategoryChildParentID:self.partID successBlk:^(id returnValue) {
            NSDictionary *blkDic = returnValue;
            self.dataSource = [blkDic objectForKey:@"datalist"];
            [self autoLayout];
            
        } failureBlk:^(id error) {
            
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarShoppingChooseOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    NSDictionary *tempDic = [self.dataSource objectAtIndex:indexPath.row];
    cell.infoLabel.text = [tempDic objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempDic = [self.dataSource objectAtIndex:indexPath.row];
    NSNumber *choosePartID = [tempDic objectForKey:@"id"];
    NSString *chooseName = [tempDic objectForKey:@"name"];
    if ([self.statuStr isEqualToString:@"UcarSpecial"]) {
    choosePartID = [tempDic objectForKey:@"goodCategoryIdLevel2"];
        self.selectID = choosePartID;
    } else {
    self.chooseIDAndName(choosePartID,chooseName);
    }

    if ([self.statuStr isEqualToString:@"UcarSpecial"]) {
      self.block(indexPath, chooseName);
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}



#pragma mark Layout
- (void)autoLayout
{
    [self.view addSubview:self.tableViewChooseType];
    WS(weakSelf)
    [weakSelf.tableViewChooseType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view).offset(60);
        make.left.and.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(self.dataSource.count * 46);
    }];
    self.tableViewChooseType.frame = CGRectMake(0, 0, 0, 0);
}


#pragma mark SET/GET
- (UITableView *)tableViewChooseType
{
    if (_tableViewChooseType == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarShoppingChooseOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseCell];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = [UIColor clearColor];
        _tableViewChooseType = tempTableView;
    }
    return _tableViewChooseType;
}


- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        NSArray *tempArray = [NSArray array];
        _dataSource = tempArray;
    }
    return _dataSource;
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
