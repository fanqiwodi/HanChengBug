//
//  LiftTableManager.m
//  Hancheng
//
//  Created by apple on 16/1/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LiftTableManager.h"
#import "LiftTableViewCell.h"
@interface LiftTableManager ()
{
    NSArray *dataArr;
    NSArray *iconArr;
    NSArray *postArr;
    
    NSMutableArray *cellArr;
    
    
}
@property (nonatomic, strong)SelectModel *model;
@property (nonatomic, copy)postBlock sBlock;
@property (nonatomic, copy)FailureBlock fBlock;
@property (nonatomic, copy)CompletionBlock cBlock;
@property (nonatomic, strong)NSString *str;
@end
@implementation LiftTableManager

- (instancetype)initWithModel:(SelectModel *)model WithIdentif:(NSString *)str WithSuccessBlock:(postBlock)sBlock WithFailure:(FailureBlock)Fblock
{
    if (self = [super init]) {
        self.model = model;
        self.str = str;
        self.sBlock = sBlock;
        self.fBlock = Fblock;
        cellArr = [NSMutableArray arrayWithCapacity:7];
        
        // 初始化内部类型
        if ([self.model.data.flag isEqualToNumber:@0]) {
            dataArr = @[@"选择车型", @"外观颜色", @"内饰颜色", @"车源类型",  @"所在地区", @"选择价位"];
            iconArr = @[@"icon_filter_car_mode_g", @"icon_filter_color_g", @"icon_filter_color_g", @"icon_filter_car_src_g",  @"icon_filter_location_g", @"icon_filter_price_g"];
            postArr = @[@[@[@"全部"], self.model.data.sourceP, self.model.data.sourceS], @[@[@"全部"], self.model.data.outsideColor], @[@[@"全部"], self.model.data.insideColor], @[@[@"全部"],self.model.data.carSourceSpotsId], @[@[@"全部"], self.model.data.province], @[@[@"不限"], @[@"从高到低", @"从低到高"]]];
        } else if ([self.model.data.flag isEqualToNumber:@1]) {
            
              dataArr = @[@"选择车型", @"外观颜色", @"内饰颜色", @"车源类型",  @"所在地区", @"亮点配置", @"选择价位"];
            iconArr = @[@"icon_filter_car_mode_g", @"icon_filter_color_g", @"icon_filter_color_g", @"icon_filter_car_src_g",  @"icon_filter_location_g", @"icon_filter_high_light_g", @"icon_filter_price_g"];
            
            if (self.model.data.sourceS.count > 0 ) {
                postArr = @[@[@[@"全部"], self.model.data.sourceP, self.model.data.sourceS], @[@[@"全部"], self.model.data.outsideColor], @[@[@"全部"], self.model.data.insideColor], @[@[@"全部"],self.model.data.carSourceSpotsId], @[@[@"全部"], self.model.data.province], @[@[@"不限"], self.model.data.point], @[@[@"不限"],@[@"从高到低", @"从低到高"]]];
            } else {
                postArr = @[@[@[@"全部"], self.model.data.sourceP], @[@[@"全部"], self.model.data.outsideColor], @[@[@"全部"], self.model.data.insideColor], @[@[@"全部"],self.model.data.carSourceSpotsId], @[@[@"全部"], self.model.data.province], @[@[@"不限"], self.model.data.point], @[@[@"不限"],@[@"从高到低", @"从低到高"]]];
            }
        
        }
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        NSArray *tempArr = postArr[path.row];
         self.sBlock(tempArr, path);
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.str forIndexPath:indexPath];
    cell.tag = indexPath.row;
    [cell.topB setTitle:dataArr[indexPath.row] forState:UIControlStateNormal];
    cell.bottomL.text = @"全部";
    [cell.topB setImage:[UIImage imageNamed:iconArr[indexPath.row]] forState:UIControlStateNormal];
    if (dataArr.count == 7) {
        if (indexPath.row == 5 ) {
            cell.bottomL.text = @"不限";
        }
        if (indexPath.row == 6) {
            cell.bottomL.text = @"不限";
        }
        
        if (indexPath.row == 0) {
            cell.topB.tintColor = [UIColor colorWithHexString:@"F94924"];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.lineView.backgroundColor = [UIColor colorWithHexString:@"F94924"];
        }else{
            cell.topB.tintColor = [UIColor colorWithHexString:@"5D5D5C"];
            cell.lineView.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"F3F2F5"];
        
        }
        
    }
    if (dataArr.count == 6) {
        if (indexPath.row == 5) {
            cell.bottomL.text = @"不限";
        }
        if (indexPath.row == 0) {
            cell.topB.tintColor = [UIColor colorWithHexString:@"F94924"];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.lineView.backgroundColor = [UIColor colorWithHexString:@"F94924"];
        }else{
            cell.topB.tintColor = [UIColor colorWithHexString:@"5D5D5C"];
            cell.lineView.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"F3F2F5"];
        }
    }

  
    
    
    [cellArr addObject:cell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tempArr = postArr[indexPath.row];
   
    

    self.sBlock(tempArr, indexPath);
    
    for (int i = 0; i < dataArr.count; i++) {
        
        if (i == indexPath.row) {
            
            LiftTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.topB.tintColor = [UIColor colorWithHexString:@"F94924"];
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            cell.lineView.backgroundColor = [UIColor colorWithHexString:@"F94924"];
            
        }else{
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
            LiftTableViewCell *cell = [tableView cellForRowAtIndexPath:index];
            cell.topB.tintColor = [UIColor colorWithHexString:@"5D5D5C"];
            cell.lineView.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"F3F2F5"];

        
        }
        
        
        
    }



}


- (NSArray *)liftCellArrl
{
    if (cellArr.count != 0) {
        return cellArr;
    }
    return nil;
}

@end
