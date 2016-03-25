//
//  SelectViewController.m
//  Hancheng
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

/*
 这个页面是筛选页面，左侧如果返回6个就是平行进口的车，如果7就是非平行进口的车型，6这种情况基本已经处理完成，但是非平行进口的筛选还没有实现。
 这个页面的设计是这样的，左边有个tableview，右边也有一个tableview，右边的数据，是根据左边的列表的点击事件生成的。
 所以把左边tableview的数据和用户事件单独拿出来放在另外一个页面，以减少这个VC的负担。具体存放位置是在：筛选页面-LiftTableManager这个类里面。通过block回调用户点击左侧列表之后的数据，拿到数据之后再这个页面处理右边的tableview的数据。如果是在处理不明白，建议重构。
 
 */

#import "SelectViewController.h"
#import "SelectModel+SelectModelAction.h"
#import "ReactiveCocoa.h"
#import "CarBandThirdModel+CarBandThirdModelAction.h"
#import "LiftTableManager.h"
#import "Right1TableViewCell.h"
#import "LiftTableViewCell.h"
@interface SelectViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    SelectModel *dataModel;

    CarBandThirdModel *carModel;
    NSMutableDictionary *searchDic;
    
    NSString *inColor;
    NSString *outColor;
    NSNumber *sourceS;
    NSNumber *carSourceSpotsId;
    NSNumber *province;
    NSString *sortBy;
    NSString *pointStr;
    NSMutableDictionary *pointDic;
    NSMutableDictionary *singleDic;
    
    NSMutableArray *multipleArr;
   
    NSNumber *carSourceCategoryIdLevel1;
    NSNumber *carSourceCategoryIdLevel2;
    
    NSMutableDictionary *showLabelDic;

    NSMutableArray *strArr;

}

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (nonatomic, strong)LiftTableManager *LiftManger;
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, strong)NSIndexPath *path;
@property (nonatomic, strong)LiftTableViewCell *cell;
@property (nonatomic, strong)NSIndexPath *stutaPath;
@property (weak, nonatomic) IBOutlet UIImageView *bottomBg;
@property (nonatomic, strong) NSString *pointStrZong;

@property (nonatomic, strong) NSMutableArray *pointArr;

@end

@implementation SelectViewController

- (IBAction)clearAction:(id)sender {
    [self initData];
    if ([dataModel.data.flag isEqualToNumber:@0]) {
        [self getCarModel0];
    }
    for ( LiftTableViewCell *cell in  self.LiftManger.liftCellArrl) {
        if ([dataModel.data.flag isEqualToNumber:@0]) {
            if (cell.tag == 5) {
                cell.bottomL.text = @"不限";
            } else {
                cell.bottomL.text = @"全部";
            }
        }
        if ([dataModel.data.flag isEqualToNumber:@1]) {
            if (cell.tag == 5 || cell.tag == 6) {
                cell.bottomL.text = @"不限";
            } else {
                cell.bottomL.text = @"全部";
            }
        }
        
    }
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [singleDic setObject:index forKey:@"0"];
    [singleDic setObject:index forKey:@"1"];
    [singleDic setObject:index forKey:@"2"];
    [singleDic setObject:index forKey:@"3"];
    [singleDic setObject:index forKey:@"4"];
    [singleDic setObject:index forKey:@"5"];
    [singleDic setObject:index forKey:@"6"];
    [self.myTableView reloadData];
    
    
}

- (IBAction)submit:(id)sender {
    NSDictionary *bigDic = @{@"condition":searchDic, @"showLabel":showLabelDic};

    [self dismissViewControllerAnimated:YES completion:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectCondition" object:bigDic];
    }];
    
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
    for (int i = 0; i < 7; i++) {
        

        
            NSIndexPath *index = singleDic[[NSString stringWithFormat:@"%d",i]];
            [uf setObject:[NSString stringWithFormat:@"%lu",index.section] forKey:[NSString stringWithFormat:@"section%d",i]];
            [uf setObject:[NSString stringWithFormat:@"%lu",index.row] forKey:[NSString stringWithFormat:@"row%d",i]];
        
        
        

    }
    for (int i = 0; i < 6; i++) {
        LiftTableViewCell *cell = self.LiftManger.liftCellArrl[i];
        [uf setObject:cell.bottomL.text forKey:[NSString stringWithFormat:@"lift%d",i]];

    }
    [uf synchronize];

    
    
}

- (void)getCarModel1
{
    [searchDic setValue:@"/api/ucarshow/getGoodsCount?goodsCategoryIdLevel2=" forKey:@"url"];
    [searchDic setValue:self.carBandID forKey:@"goodsCategoryIdLevel2"];
    [searchDic setValue:outColor forKey:@"outsideColor"];
    if ([outColor isEqualToString:@"全部"]) {
        [searchDic setValue:@"" forKey:@"outsideColor"];

    }
    [searchDic setValue:carSourceSpotsId forKey:@"carSourceSpotsId"];
    [searchDic setValue:province forKey:@"province"];
    [searchDic setValue:inColor forKey:@"insideColor"];
    if ([inColor isEqualToString:@"全部"]) {
        [searchDic setValue:@"" forKey:@"insideColor"];

    }
    [searchDic setValue:sortBy forKey:@"sortBy"];
    [searchDic setValue:carSourceCategoryIdLevel1 forKey:@"carSourceCategoryIdLevel1"];
    [searchDic setValue:carSourceCategoryIdLevel2 forKey:@"carSourceCategoryIdLevel2"];
    
    [searchDic setValue:sourceS forKey:@"goodsTemplateId"];
//    pointStr = [[pointDic allValues]componentsJoinedByString:@","];
    
    if (self.pointArr.count == 1) {
        self.pointStrZong = [self.pointArr[0] stringValue];
    }
    else{
    
        for (int i = 1; i < self.pointArr.count; i++) {
            self.pointStrZong = [self.pointStrZong stringByAppendingString:[NSString stringWithFormat:@",%@", [self.pointArr[i] stringValue]]];
            
        }
    }
    
    [searchDic setValue:self.pointStrZong forKey:@"point"];
    [CarBandThirdModel handleFlag1Block:^(id returnValue) {
        carModel = returnValue;
        NSString *str = [NSString stringWithFormat:@"%@", carModel.totalCount];
        _countLabel.text = [NSString stringWithFormat:@"共%@车源",str];
        [searchDic setValue:str forKey:@"pageSize"];
    } WithFailureBlock:^(id error) {
        
    } Param:searchDic];
    
//    NSLog(@"-%@-,", searchDic);
}

- (void)getCarModel0
{
   
    [searchDic setValue:self.carBandID forKey:@"goodsCategoryIdLevel2"];
    [searchDic setValue:@"/api/ucarshow/getGoodsCount?goodsCategoryIdLevel2=" forKey:@"url"];
    [searchDic setValue:sourceS forKey:@"goodsTemplateId"];
    [searchDic setValue:outColor forKey:@"outsideColor"];
    [searchDic setValue:carSourceSpotsId forKey:@"carSourceSpotsId"];
    [searchDic setValue:province forKey:@"province"];
    [searchDic setValue:inColor forKey:@"insideColor"];
    [searchDic setValue:sortBy forKey:@"sortBy"];
    [searchDic setValue:self.pointStrZong forKey:@"point"];

    
        [CarBandThirdModel handleSelectBlock:^(id returnValue) {
            carModel = returnValue;
            NSString *str = [NSString stringWithFormat:@"共%@条车源", carModel.totalCount];
            _countLabel.text = str;
            
            [searchDic setValue:str forKey:@"pageSize"];
        } WithFailureBlock:^(id error) {
            
        } Param:searchDic];
 
//    NSLog(@"-%@-", searchDic);

}

- (void)getNetData
{
    WS(myself);
    
    [SelectModel handleWithSuccessBlock:^(id returnValue) {
//        NSLog(@"-%@", returnValue);
        dataModel = returnValue;
        myself.LiftManger = [[LiftTableManager alloc]initWithModel:dataModel WithIdentif:@"why" WithSuccessBlock:^(id returnValue, id postBlock) {

            myself.dataArr = returnValue;
            myself.path = postBlock;

           [myself.myTableView reloadData];

        } WithFailure:^(id error) {
         
        }];
        [self initTableViewLift];
    } WithFailureBlock:^(id error) {
        NSLog(@"错误");
    } BrandId:self.carBandID];
}

- (void)initTableView
{
  

    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(200*REM, 0, screen_width-200*REM, screen_height-120) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"Right1TableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([Right1TableViewCell class])];
    [self.myTableView setTableFooterView:[UIView new]];
    [self.view addSubview:self.myTableView];
}

- (void)initTableViewLift
{
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 190*REM, H(self.view)-44) style:UITableViewStylePlain];
    _leftTableView.dataSource = self.LiftManger;
    _leftTableView.delegate = self.LiftManger;
    _leftTableView.backgroundColor = [UIColor colorWithHexString:@"F3F2F5"];
    [self.view addSubview:_leftTableView];
    [_leftTableView registerNib:[UINib nibWithNibName:@"LiftTableViewCell" bundle:nil] forCellReuseIdentifier:@"why"];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_leftTableView setTableFooterView:[UIView new]];
}



- (void)initData
{
    inColor = @"";
    outColor = @"";
    sourceS = @0;
    carSourceSpotsId = @0;
    province = @0;
    carSourceCategoryIdLevel2 = @0;
    carSourceCategoryIdLevel1 = @0;
    sortBy = @"";
    pointDic = [NSMutableDictionary dictionary];
    pointStr = @"";
    searchDic = [NSMutableDictionary dictionary];
//    singleDic = [NSMutableDictionary dictionary];
    multipleArr = [NSMutableArray array];
    
    showLabelDic = [NSMutableDictionary dictionary];

    strArr = [NSMutableArray array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottomBg.image = [UIImage imageNamed:@"筛选bg"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"筛选页关闭_点击"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
  
    
    self.title = @"筛选条件";
    // Do any additional setup after loading the view from its nib.
    self.clearButton.titleLabel.font = [UIFont systemFontOfSize:25*REM];
    [self.clearButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(60*REM));
    }];
}

- (void)backAction:(UIBarButtonItem *)item
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (dataModel) {
            [self.myTableView removeFromSuperview];
            [self.leftTableView removeFromSuperview];
        }
       
    }];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([dataModel.data.flag isEqualToNumber:@1]) {
        switch (self.path.row) {
            case 0:
                if (section == 1) {
                    return @"平行进口";
                }
                if (section == 2) {
                    return @"中规进口";
                }
                break;
                
            default:
                break;
        }
    }
    if ([dataModel.data.flag isEqualToNumber:@0]) {
        switch (self.path.row) {
            case 0:
            {
                if (section != 0) {
                selectModel_sourceS *s = [self.dataArr lastObject][section-1];
                    return s.modelYear;
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([dataModel.data.flag isEqualToNumber:@1]) {
        return self.dataArr.count;
   }
    if ([dataModel.data.flag isEqualToNumber:@0]) {
        if (self.path.row == 0) {
            if ([[self.dataArr lastObject] count] == 1) {
//                NSLog(@"--1---%lu", self.dataArr.count-1);
                return self.dataArr.count-1;
            } else {
//                NSLog(@"--2---%lu", self.dataArr.count);
                return [[self.dataArr lastObject] count] + 1;
            }
        } else {
           return self.dataArr.count;
        }
        
       
    }
    
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dataModel.data.flag isEqualToNumber:@1]) {
         return [self.dataArr[section] count];
    }
    if ([dataModel.data.flag isEqualToNumber:@0]) {
        if (self.path.row != 0) {
          
          return [self.dataArr[section] count];
            
        } else {
            if (section == 0) {
                return 1;
            } else {
                
                selectModel_sourceS *s = [self.dataArr lastObject][section-1];
                return s.value.count;
                
            }
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([dataModel.data.flag isEqualToNumber:@1]) {
        switch (self.path.row) {
            case 0:
            {
                if (section != 0) {
                    return 45 * REM;
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    if ([dataModel.data.flag isEqualToNumber:@0]) {
        switch (self.path.row) {
            case 0:
            {
                if (section != 0) {
                    return 45*REM;
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Right1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Right1TableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"464646"];
    [[cell.contentView viewWithTag:10] removeFromSuperview];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isClick = NO;

    if ([dataModel.data.flag isEqualToNumber:@1]) {
        switch (self.path.row) {
            case 0:
            {
                
                cell.str = @"";

                if ([indexPath isEqual:[singleDic objectForKey:@"0"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }

                if (indexPath.section == 0) {
                    cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
                
                    carSourceCategoryIdLevel1 = @0;
                    carSourceCategoryIdLevel2 = @0;
                }
                if (indexPath.section == 1) {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    cell.nameL.text = m1.name;
                    carSourceCategoryIdLevel1 = m1.myID;
                }
                
                if (indexPath.section == 2) {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    cell.nameL.text = m1.shortName;
                    carSourceCategoryIdLevel2 = m1.myID;
                    UILabel *moneyL = [UILabel new];
                    moneyL.tag = 10;
                    [cell.contentView addSubview:moneyL];
                    [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(cell.contentView.mas_centerY);
                        make.width.equalTo(@(80*REM));
                        make.right.equalTo(cell.contentView.mas_right).offset(-10*REM);
                    }];
                    moneyL.font = [UIFont systemFontOfSize:14];
                    moneyL.textColor = [UIColor colorWithHexString:@"B4B4B4"];
                    moneyL.text = [NSString stringWithFormat:@"%@万", m1.guidePrice];
                }
            }
                break;
            case 1:
            {
                
               
                cell.str = @"";

                    if ([indexPath isEqual:[singleDic objectForKey:@"1"]]) {
                        cell.isClick = YES;
                    } else {
                        cell.isClick = NO;
                    }
                
                
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
            
                cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
            }
                break;
            case 2:
            {
                cell.str = @"";

                if ([indexPath isEqual:[singleDic objectForKey:@"2"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                    
                }
             
                cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
            }
                
                break;
            case 3:
            {
                cell.str = @"";

                if ([indexPath isEqual:[singleDic objectForKey:@"3"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
                if (indexPath.section == 0) {
                    cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];

                }
                if (indexPath.section == 1) {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    cell.nameL.text = m1.name;
                }
            }
                
                break;
            case 4:
            {
                cell.str = @"";

                if ([indexPath isEqual:[singleDic objectForKey:@"4"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
                if (indexPath.section == 0) {
                    cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];

                }
                if (indexPath.section == 1) {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    cell.nameL.text = m1.name;
                }
            }
                
                break;
            case 5:
            {
                
                cell.str = @"321";
                if ([multipleArr containsObject:indexPath]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if (multipleArr.count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
                
                if (indexPath.section == 0) {
                    cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];

                }
                if (indexPath.section == 1) {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    cell.nameL.text = m1.name;
                }

            }
                
                break;
            case 6:
            {
                cell.str = @"";

                if ([indexPath isEqual:[singleDic objectForKey:@"6"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
              
                cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
                
            }
                
                break;
                
            default:
                break;
        }

    }
    
    if ([dataModel.data.flag isEqualToNumber:@0]) {
        switch (self.path.row) {
            case 0:
            {
                if ([indexPath isEqual:[singleDic objectForKey:@"0"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
                if (indexPath.section == 0) {
                    cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
                    
                } else {
                    
                 selectModel_sourceS *s = [self.dataArr lastObject][indexPath.section-1];
                 selectModel_sourceS_son *ss  = s.value[indexPath.row];
                    cell.nameL.text = ss.name;
                    
                    UILabel *moneyL = [UILabel new];
                    moneyL.tag = 10;
                    [cell.contentView addSubview:moneyL];
                    [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(cell.contentView.mas_centerY);
                        make.width.equalTo(@(120*REM));
                        make.right.equalTo(cell.contentView.mas_right).offset(10*REM);
                    }];
                    moneyL.font = [UIFont systemFontOfSize:14];
                    moneyL.textColor = [UIColor colorWithHexString:@"B4B4B4"];
                    moneyL.text = [NSString stringWithFormat:@"%@万", ss.guidePrice];
                   
                }
            }
                break;
            case 1:
            {
                if ([indexPath isEqual:[singleDic objectForKey:@"1"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
                cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
            }
                break;
            case 2:
            {
                if ([indexPath isEqual:[singleDic objectForKey:@"2"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
                cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
            }
                break;
            case 3:
            {
                if ([indexPath isEqual:[singleDic objectForKey:@"3"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
                if (indexPath.section == 0) {
                    cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
                }
                if (indexPath.section == 1) {
                  selectID_NameModel *m = self.dataArr[indexPath.section][indexPath.row];
                    cell.nameL.text = m.name;
                }
            }
                break;
            case 4:
            {
                if ([indexPath isEqual:[singleDic objectForKey:@"4"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
                if (indexPath.section == 0) {
                    cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
                }
                if (indexPath.section == 1) {
                    selectID_NameModel *m = self.dataArr[indexPath.section][indexPath.row];
                    cell.nameL.text = m.name;
                }
            }
                break;
            case 5:
            {
                if ([indexPath isEqual:[singleDic objectForKey:@"5"]]) {
                    cell.isClick = YES;
                } else {
                    cell.isClick = NO;
                }
                if ([singleDic allValues].count == 0) {
                    if (indexPath.section == 0 && indexPath.row == 0) {
                        cell.isClick = YES;
                    }
                }
               
            cell.nameL.text = self.dataArr[indexPath.section][indexPath.row];
              
            }
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([dataModel.data.flag isEqualToNumber:@1]) {
        switch (self.path.row) {
            case 0:
            {
                self.cell = self.LiftManger.liftCellArrl[0];
                
                if (indexPath.section == 0) {
                    self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                   [showLabelDic removeObjectForKey:@"0"];
                }
                if (indexPath.section == 1) {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    if (indexPath.row == 0) {
                 carSourceCategoryIdLevel1 = m1.myID;
                 carSourceCategoryIdLevel2 = @0;
                    } else {
                 carSourceCategoryIdLevel1 = @0;
                 carSourceCategoryIdLevel2 = m1.myID;
                    }
                    self.cell.bottomL.text = m1.name;
                   [showLabelDic setValue:m1.name forKey:@"0"];
                }
                
                if (indexPath.section == 2) {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];


                    self.cell.bottomL.text = m1.shortName;
                    [showLabelDic setValue:m1.shortName forKey:@"0"];
        
               }
                [singleDic setValue:indexPath forKey:@"0"];
                [tableView reloadData];
            }
                break;
            case 1:
            {
                if (indexPath.section == 0) {
                    outColor = @"";
                    [showLabelDic removeObjectForKey:@"1"];
                }
                outColor = self.dataArr[indexPath.section][indexPath.row];
                 LiftTableViewCell *cell = self.LiftManger.liftCellArrl[1];
                 cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                
                [singleDic setValue:indexPath forKey:@"1"];
                 [showLabelDic setValue:self.cell.bottomL.text forKey:@"1"];
                [tableView reloadData];
            }
                break;
            case 2:
            {
                if (indexPath.section == 0) {
                    inColor = @"";
                     [showLabelDic removeObjectForKey:@"2"];
                }
                inColor = self.dataArr[indexPath.section][indexPath.row];
                self.cell = self.LiftManger.liftCellArrl[2];
                self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                [showLabelDic setValue:self.cell.bottomL.text forKey:@"2"];
                [singleDic setValue:indexPath forKey:@"2"];
                [tableView reloadData];
            }
                break;
            case 3:
            {
                self.cell = self.LiftManger.liftCellArrl[3];
                if (indexPath.section == 0) {
                    self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                    carSourceSpotsId = @0;
                     [showLabelDic removeObjectForKey:@"3"];
                } else {
                
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    self.cell.bottomL.text = m1.name;
                     [showLabelDic setValue:self.cell.bottomL.text forKey:@"3"];
                    carSourceSpotsId = m1.myID;

                }
                [singleDic setValue:indexPath forKey:@"3"];
                [tableView reloadData];
            }
                break;
            case 4:
            {
                self.cell = self.LiftManger.liftCellArrl[4];
                if (indexPath.section == 0) {
                    self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                    province = @0;
                     [showLabelDic removeObjectForKey:@"4"];
                } else {
                
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    self.cell.bottomL.text = m1.name;
                     [showLabelDic setValue:self.cell.bottomL.text forKey:@"4"];
                    province = m1.myID;
                
              }
                [singleDic setValue:indexPath forKey:@"4"];
                [tableView reloadData];
            }
                break;
            case 5:
            {
                
                 self.cell = self.LiftManger.liftCellArrl[5];
                if (indexPath.section == 0) {
                self.cell.bottomL.text = @"不限";
                  NSString *keyIndexPath = [indexPath modelToJSONString];
                 pointStr = @"";
               [showLabelDic removeObjectForKey:@"5"];
                 pointDic = [self cheRepeatDicWiht:keyIndexPath addObj:pointStr];
                    
                    self.pointArr = [NSMutableArray array];
                    self.pointStrZong = @"";
                    
                    for (int i = 0; i < self.dataArr.count; i++) {

                        if (i == 0) {
                            Right1TableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

                            cell1.nameL.textColor = [UIColor redColor];
                        }else{
                            Right1TableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i-1 inSection:1]];

                            cell1.isClick = NO;
                        
                        }
                    }
                    
                    [multipleArr removeAllObjects];
                    
                    
                    
                } else {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];

                    pointStr = [m1.myID stringValue];
                    NSString *keyIndexPath = [indexPath modelToJSONString];
                    pointDic = [self cheRepeatDicWiht:keyIndexPath addObj:pointStr];
                 
       
                    multipleArr  = [self checkRepeatObj:indexPath identif:0];
                    strArr = [self checkRepeatObj:m1.name identif:1];
                  self.cell.bottomL.text = [strArr componentsJoinedByString:@" "];
                    [showLabelDic setValue:self.cell.bottomL.text forKey:@"5"];
                    
                    int ii = 20;
                    
                    NSMutableArray *arr = [NSMutableArray array];
                    
                
                    
                    if (self.pointArr.count == 0) {
                        self.pointArr = [NSMutableArray array];
                        [self.pointArr addObject:m1.myID];
                        
                    }else{
                    
                        for (int i = 0; i < self.pointArr.count; i++) {
                            
                            if ([m1.myID isEqual:self.pointArr[i]]) {
                                ii = i;
                            }
                            
                        }
                        if (ii != 20) {
                            [self.pointArr removeObjectAtIndex:ii];
                        }else{
                            [arr addObject:m1.myID];
                            [self.pointArr addObjectsFromArray:arr];
                        }
                    }
                    
                
                   

                }

               [tableView reloadData];
                
            }
                
                break;
            case 6:
            {
                if (indexPath.section == 0) {
                    sortBy = @"";
                     [showLabelDic removeObjectForKey:@"6"];
                } else {
                    if (indexPath.row == 0) {
                        sortBy = @"DESC";
                    }
                    if (indexPath.row == 1) {
                        sortBy = @"ASC";
                    }
                }
                self.cell = self.LiftManger.liftCellArrl[6];
                self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                 [showLabelDic setValue:self.cell.bottomL.text forKey:@"6"];
                [singleDic setValue:indexPath forKey:@"6"];
                [tableView reloadData];
            }
                break;
            default:
                break;
        }
        [self getCarModel1];
       
    }
    
    if ([dataModel.data.flag isEqualToNumber:@0]) {
        switch (self.path.row) {
            case 0:
            {
            self.cell = self.LiftManger.liftCellArrl[0];
            if (indexPath.section == 0) {
            self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
            sourceS = @0;
                [showLabelDic removeObjectForKey:@"0"];
            } else {
                selectModel_sourceS *s = [self.dataArr lastObject][indexPath.section-1];
                selectModel_sourceS_son *ss  = s.value[indexPath.row];
                self.cell.bottomL.text = ss.name;
                sourceS = ss.myID;
                [showLabelDic setValue:ss.name forKey:@"0"];
            }
                [singleDic setValue:indexPath forKey:@"0"];
                [tableView reloadData];
            }
                break;
            case 1:
            {
                
                self.cell = self.LiftManger.liftCellArrl[1];
                self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                outColor = self.dataArr[indexPath.section][indexPath.row];
                [singleDic setValue:indexPath forKey:@"1"];
                [tableView reloadData];
                [showLabelDic setValue:self.cell.bottomL.text forKey:@"1"];
                
                
                if (indexPath.section == 0) {
                    outColor = @"";
                    [showLabelDic removeObjectForKey:@"1"];
                }
                
                
            }
                break;
            case 2:
            {
             
                self.cell = self.LiftManger.liftCellArrl[2];
                self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                inColor = self.dataArr[indexPath.section][indexPath.row];
                [singleDic setValue:indexPath forKey:@"2"];
                [tableView reloadData];
                [showLabelDic setValue:self.cell.bottomL.text forKey:@"2"];
                if (indexPath.section == 0) {
                    inColor = @"";
                    [showLabelDic removeObjectForKey:@"2"];
                }
            }
                break;
            case 3:
            {
                 self.cell = self.LiftManger.liftCellArrl[3];
                if (indexPath.section == 0) {
                    self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                    carSourceSpotsId = @0;
                    [showLabelDic removeObjectForKey:@"3"];
                } else {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    self.cell.bottomL.text = m1.name;
                    carSourceSpotsId = m1.myID;
                    [showLabelDic setValue:self.cell.bottomL.text forKey:@"3"];

                }
                [singleDic setValue:indexPath forKey:@"3"];
                [tableView reloadData];
            }
                
                break;
            case 4:
            {
                self.cell = self.LiftManger.liftCellArrl[4];
                if (indexPath.section == 0) {
                    self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
                    province = @0;
                    [showLabelDic removeObjectForKey:@"4"];
                } else {
                    selectID_NameModel *m1 = self.dataArr[indexPath.section][indexPath.row];
                    self.cell.bottomL.text = m1.name;
                    province = m1.myID;
                [showLabelDic setValue:self.cell.bottomL.text forKey:@"4"];
                }
                [singleDic setValue:indexPath forKey:@"4"];
                [tableView reloadData];
            }
                break;
            case 5:
            {
                if (indexPath.section == 0) {
                    sortBy = @"";
                    self.cell.bottomL.text = @"不限";
                    [showLabelDic removeObjectForKey:@"5"];
                } else {
                    if (indexPath.row == 0) {
                       sortBy = @"DESC";
                       [showLabelDic setValue:@"从高到低" forKey:@"5"];
                    }
                    if (indexPath.row == 1) {
                        sortBy = @"ASC";
                        [showLabelDic setValue:@"从低到高" forKey:@"5"];
                    }
                self.cell = self.LiftManger.liftCellArrl[5];
                self.cell.bottomL.text = self.dataArr[indexPath.section][indexPath.row];
               
                
            }
                [singleDic setValue:indexPath forKey:@"5"];
                [tableView reloadData];

            }
                break;
            default:
                break;
        }
        [self getCarModel0];
    }
    
   
}

// 检查是否重复
- (NSMutableArray *)checkRepeatObj:(id)obj identif:(NSInteger )stuta
{
    NSMutableArray *arr;
    switch (stuta) {
        case 0:
        {
            arr = multipleArr.mutableCopy;
        }
            break;
        case 1:
        {
            arr = strArr.mutableCopy;
        }
            break;
        default:
            break;
    }
    
    if (![arr containsObject:obj]) {
        [arr addObject:obj];
    } else
    {
        [arr removeObject:obj];
    }
    
    return arr;
}


- (NSMutableDictionary *)cheRepeatDicWiht:(NSString *)key addObj:(id)obj
{
    NSMutableDictionary *dic = pointDic.mutableCopy;
    if (![dic containsObjectForKey:key]) {
        if (key.length != 0) {
             [dic setValue:obj forKey:key];
        }
    } else {
        [dic removeObjectForKey:key];
    }
    return dic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 隐藏底部bar;
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
    singleDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < 7; i++) {
        NSString *sectoin = [uf objectForKey:[NSString stringWithFormat:@"section%d", i]];
        NSString *row = [uf objectForKey:[NSString stringWithFormat:@"row%d", i]];

        NSIndexPath *index1 = [NSIndexPath indexPathForRow:[row integerValue] inSection:[sectoin integerValue]];
        [singleDic setObject:index1 forKey:[NSString stringWithFormat:@"%d", i]];
    }
//    [singleDic setObject:index forKey:@"0"];
//    [singleDic setObject:index forKey:@"1"];
//    [singleDic setObject:index forKey:@"2"];
//    [singleDic setObject:index forKey:@"3"];
//    [singleDic setObject:index forKey:@"4"];
//    [singleDic setObject:index forKey:@"5"];
//    [singleDic setObject:index forKey:@"6"];

    [self getNetData];
    
    [self initData];
    
    [self initTableView];
    
    [self getCarModel0];
    
    if ([self.statuStr isEqualToString:@"清除"]) {
        [self initData];
        self.countLabel.text = @"";
        [self.myTableView reloadData];
        [self.leftTableView reloadData];
    }

    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    _myTableView.delegate = nil;
    
    self.statuStr = @"";
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
