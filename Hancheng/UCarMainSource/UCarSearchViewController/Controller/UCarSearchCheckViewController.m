//
//  UCarSearchCheckViewController.m
//  Hancheng
//
//  Created by Tony on 16/2/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UCarSearchCheckViewController.h"
#import "UCarMainSourceNetwork.h"
#import "UCarSearchMainTableViewCell.h"
#import "UCarSearchStepTableViewCell.h"


static NSString *const reuseMainCell = @"UCarSearchMainTableViewCell";
static NSString *const reuseStepCell = @"UCarSearchStepTableViewCell";
@interface UCarSearchCheckViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *clearButtonWidth;
@property (strong, nonatomic) IBOutlet UIView *topNavigationView;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
@property (strong, nonatomic) IBOutlet UIView *cornerRedView;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UIButton *makeSureButton;
@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) UITableView *tableViewMain;
@property (nonatomic, strong) UITableView *tableViewStep;


@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UCarMainSearchA89Model_data *modelA89;
@property (nonatomic, strong) NSArray *keyArray;
@property (nonatomic, strong) NSMutableArray *seletedNameArray;
@property (nonatomic, strong) NSArray *imageNameArray;

@end

@implementation UCarSearchCheckViewController
{
    NSInteger _seletedMain;
    NSInteger _brandSeletedIndex;
    NSInteger _outsideColorIndex;
    NSInteger _insideColorIndex;
    NSInteger _carSeletedIndex;
    NSInteger _provinceIndex;
    NSInteger _priceIndex;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    // Do any additional setup after loading the view.
    self.clearButtonWidth.constant = 86 *LAYOUT_SIZE;
    self.bottomViewHeight.constant = 49;
    self.cornerRedView.layer.cornerRadius = 20.5;
    self.cornerRedView.layer.masksToBounds = YES;
    _seletedMain = _brandSeletedIndex = _outsideColorIndex = _insideColorIndex = _carSeletedIndex = _priceIndex = _provinceIndex = 0;
    [self configGetSourceData];
    [self configNumber];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableViewMain]) {
        return self.dataSource.count - 1;
    } else {
        return [self.dataSource[_seletedMain] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableViewMain]) {
        return 60;
    } else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UCarSearchMainTableViewCell *cellMain = [tableView dequeueReusableCellWithIdentifier:reuseMainCell];
    UCarSearchStepTableViewCell *cellStep = [tableView dequeueReusableCellWithIdentifier:reuseStepCell];
    cellStep.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([tableView isEqual:self.tableViewMain]) {
        if (indexPath.row == _seletedMain) {
            cellMain.pageState = 1;
        } else {
            cellMain.pageState = 0;
        }
        cellMain.titleLabel.text = [self.keyArray objectAtIndex:indexPath.row];
        cellMain.titleImageView.image = [UIImage imageNamed:[self.imageNameArray objectAtIndex:indexPath.row]];
        cellMain.infoLabel.text  = [self.seletedNameArray objectAtIndex:indexPath.row];
        return cellMain;
    } else {
        cellStep.pageState = 0;
        switch (_seletedMain) {
            case 0:
                if (_brandSeletedIndex == indexPath.row) {
                    cellStep.pageState = 1;
                }
                break;
            case 1:
                if (_outsideColorIndex == indexPath.row) {
                    cellStep.pageState = 1;
                }
                break;
            case 2:
                if (_insideColorIndex == indexPath.row) {
                    cellStep.pageState = 1;
                }
                break;
            case 3:
                if (_carSeletedIndex == indexPath.row) {
                    cellStep.pageState = 1;
                }
                break;
            case 4:
                if (_provinceIndex == indexPath.row) {
                    cellStep.pageState = 1;
                }
                break;
            case 5:
                if (_priceIndex == indexPath.row) {
                    cellStep.pageState = 1;
                }
                
                break;
            default:
                break;
        }
        NSArray *tempArray = [self.dataSource objectAtIndex:_seletedMain];
        cellStep.titleLabel.text = [tempArray objectAtIndex:indexPath.row];
        return cellStep;
    }
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableViewMain]) {
        _seletedMain = indexPath.row;
        [self.tableViewMain reloadData];
        [self.tableViewStep reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        NSString *tempString = [NSString new];
        NSArray *tempArray = [self.dataSource objectAtIndex:_seletedMain];
        tempString = [tempArray objectAtIndex:indexPath.row];
        switch (_seletedMain) {
            case 0:
                _brandSeletedIndex = indexPath.row;
                [self.params setValue:tempString forKey:@"brandName"];
                break;
            case 1:
                _outsideColorIndex = indexPath.row;
                [self.params setValue:tempString forKey:@"outsideColor"];
                break;
            case 2:
                _insideColorIndex = indexPath.row;
                [self.params setValue:tempString forKey:@"insideColor"];
                break;
            case 3:
                _carSeletedIndex = indexPath.row;
                [self.params setValue:tempString forKey:@"carSourceSpotsName"];
                break;
            case 4:
                _provinceIndex = indexPath.row;
                [self.params setValue:tempString forKey:@"provinceName"];
                break;
            case 5:
                _priceIndex = indexPath.row;
                [self.params setValue:tempString forKey:@"sortBy"];
                break;
            default:
                break;
        }
        [self.seletedNameArray replaceObjectAtIndex:_seletedMain withObject:tempString];
        [self.tableViewMain reloadData];
        [self.tableViewStep reloadData];
        [self configNumber];
    }
}



#pragma mark CheckNumber
- (void)configNumber
{
    NSString *brandNameString = [self.params valueForKey:@"brandName"];
    NSString *carSourceString = [self.params valueForKey:@"carSourceSpotsName"];
    NSString *outsideCoString = [self.params valueForKey:@"outsideColor"];
    NSString *insideColString = [self.params valueForKey:@"insideColor"];
    NSString *provinceNString = [self.params valueForKey:@"provinceName"];
    NSString *sortPriceString = [self.params valueForKey:@"sortBy"];
    
    if ([brandNameString isEqualToString:@"全部"]) {
        [self.params setValue:nil forKey:@"brandName"];
    }
    if ([carSourceString isEqualToString:@"全部"]) {
        [self.params setValue:nil forKey:@"carSourceSpotsName"];
    }
    if ([outsideCoString isEqualToString:@"全部"]) {
        [self.params setValue:nil forKey:@"outsideColor"];
    }
    if ([insideColString isEqualToString:@"全部"]) {
        [self.params setValue:nil forKey:@"insideColor"];
    }
    if ([provinceNString isEqualToString:@"全部"]) {
        [self.params setValue:nil forKey:@"provinceName"];
    }
    if ([sortPriceString isEqualToString:@"不限"]) {
        [self.params setValue:nil forKey:@"sortBy"];
    } else if ([sortPriceString isEqualToString:@"从低到高"]) {
        [self.params setValue:@"ASC" forKey:@"sortBy"];
    } else if ([sortPriceString isEqualToString:@"从高到低"]) {
        [self.params setValue:@"DESC" forKey:@"sortBy"];
    }
    
    [self.params setValue:self.keyWord forKey:@"keyWord"];
    [UCarMainSourceNetwork GETWithA92keyDictory:self.params successblk:^(id returnValue) {
        NSNumber *tempNumber = returnValue;
        self.numberLabel.text = [NSString stringWithFormat:@"共%@条车源",tempNumber];
    } failure:^(id error) {
        
    }];
}
- (void)configGetSourceData
{
    if (!self.keyWord) {
        return;
    }
    [UCarMainSourceNetwork GETWithA89KeyWord:self.keyWord successBlk:^(id returnValue) {
        self.modelA89 = returnValue;
        // 处理数据为数组
        NSMutableArray *brandNameArray = [NSMutableArray arrayWithArray:[self.modelA89.brandName componentsSeparatedByString:@","]];
        NSMutableArray *carSourceSpotsNameArray = [NSMutableArray arrayWithArray:[self.modelA89.carSourceSpotsName componentsSeparatedByString:@","]];
        NSMutableArray *outsideColorArray = [NSMutableArray arrayWithArray:[self.modelA89.outsideColor componentsSeparatedByString:@","]];
        NSMutableArray *insideColorArray = [NSMutableArray arrayWithArray:[self.modelA89.insideColor componentsSeparatedByString:@","]];
        NSMutableArray *provinceNameArray = [NSMutableArray arrayWithArray:[self.modelA89.provinceName componentsSeparatedByString:@","]];
        
        if (!brandNameArray) { brandNameArray = [NSMutableArray arrayWithArray:@[@"全部",self.modelA89.brandName]]; }
        else { [brandNameArray insertObject:@"全部" atIndex:0];}
        if (!carSourceSpotsNameArray) { carSourceSpotsNameArray = [NSMutableArray arrayWithArray:@[@"全部",self.modelA89.carSourceSpotsName]];} else { [carSourceSpotsNameArray insertObject:@"全部" atIndex:0]; }
        if (!outsideColorArray) { outsideColorArray = [NSMutableArray arrayWithArray:@[@"全部",self.modelA89.outsideColor]]; }
        else { [outsideColorArray insertObject:@"全部" atIndex:0]; }
        if (!insideColorArray) { insideColorArray = [NSMutableArray arrayWithArray:@[@"全部",self.modelA89.insideColor]]; }
        else { [insideColorArray insertObject:@"全部" atIndex:0]; };
        if (!provinceNameArray) { provinceNameArray = [NSMutableArray arrayWithArray:@[@"全部",self.modelA89.provinceName]]; }
        else { [provinceNameArray insertObject:@"全部" atIndex:0]; };
        self.dataSource = @[brandNameArray, outsideColorArray, insideColorArray, carSourceSpotsNameArray, provinceNameArray,@[@"不限",@"从低到高",@"从高到低"]];
        [self.view addSubview:self.tableViewMain];
        [self.view addSubview:self.tableViewStep];
        [self configLayout];
        [self.tableViewMain reloadData];
        [self.tableViewStep reloadData];
        
    } failureBlk:^(id error) {
        
    }];
}

#pragma mark ButtonAction
- (IBAction)makeSureButtonAction:(id)sender {
    self.blockParams(self.params, self.seletedNameArray);
    [self dismissViewControllerAnimated:YES completion:nil]; 
}
- (IBAction)dismissButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clearButtonAction:(id)sender {
    [self setClearAction];
}
- (void)setClearAction
{
    self.params = [NSMutableDictionary new];
    [self.params setValue:self.keyWord forKey:@"keyWord"];
    _seletedMain = _brandSeletedIndex = _outsideColorIndex = _insideColorIndex = _carSeletedIndex = _priceIndex = _provinceIndex = 0;
    self.seletedNameArray = [NSMutableArray new];
    [self.seletedNameArray addObjectsFromArray:@[@"全部",@"全部",@"全部",@"全部",@"全部",@"不限"]];
    [self configGetSourceData];
    [self configNumber];
}

#pragma mark Layout
- (void)configLayout
{   WS(weakSelf)
    [weakSelf.tableViewMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.topNavigationView.mas_bottom);
        make.bottom.equalTo(weakSelf.bottomView.mas_top);
        make.width.mas_equalTo(96);}];
    
    [weakSelf.tableViewStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topNavigationView.mas_bottom);
        make.bottom.equalTo(weakSelf.bottomView.mas_top);
        make.right.mas_equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.tableViewMain.mas_right);
    }];
}


#pragma mark SET/GET
- (UITableView *)tableViewMain {
    if (_tableViewMain == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.backgroundColor = HEXCOLOR(0xf5f5f7);
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarSearchMainTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseMainCell];
        _tableViewMain = tempTableView;
    }
    return _tableViewMain;
}

- (UITableView *)tableViewStep {
    if (_tableViewStep == nil) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UCarSearchStepTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseStepCell];
        _tableViewStep = tempTableView;
    }
    return _tableViewStep;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        NSArray *tempArray = [NSArray new];
        _dataSource = tempArray;
    }
    return _dataSource;
}

- (NSMutableDictionary *)params {
    if (_params == nil) {
        NSMutableDictionary *tempDictory = [NSMutableDictionary new];
        _params = tempDictory;
    }
    return _params;
}

- (UCarMainSearchA89Model_data *)modelA89
{
    if (_modelA89 == nil) {
        UCarMainSearchA89Model_data *tempData = [UCarMainSearchA89Model_data new];
        _modelA89 = tempData;
    }
    return _modelA89;
}

- (NSArray *)keyArray
{
    if (_keyArray == nil) {
        NSArray *tempArray = @[@"品牌名称",@"外饰颜色",@"内饰颜色",@"车源类型",@"所在地区",@"选择价位"];
        _keyArray = tempArray;
    }
    return _keyArray;
}

- (NSMutableArray *)seletedNameArray
{
    if (_seletedNameArray == nil) {
        NSMutableArray *tempArray = [NSMutableArray new];
        [tempArray addObjectsFromArray:@[@"全部",@"全部",@"全部",@"全部",@"全部",@"不限"]];
        _seletedNameArray = tempArray;
    }
    return _seletedNameArray;
}

- (NSArray *)imageNameArray
{
    if (_imageNameArray == nil) {
        NSArray *tempArray = @[@"icon_filter_car_mode_g",@"icon_filter_color_g",@"icon_filter_color_g",
                               @"icon_filter_car_src_g",@"icon_filter_location_g",@"icon_filter_price_g"];
        _imageNameArray = tempArray;
    }
    return _imageNameArray;
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
