//
//  CarbandTableViewDataResource.m
//  Hancheng
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CarbandTableViewDataResource.h"
#import "YYKit.h"
@interface CarbandTableViewDataResource()
{
    NSMutableArray *sectionArr;
    NSMutableArray *rowArr;

    NSMutableArray *indexArr;
}
@property (nonatomic, strong) NSString *identifStr;
@property (nonatomic, strong) CarBandSecondModel *model;
@property (nonatomic, copy) returncell block;
@end


@implementation CarbandTableViewDataResource
- (id)initWithIdentifStr:(NSString *)str carBandModel:(CarBandSecondModel *)model callBackBlock:(returncell)block
{
    if (self = [super init]) {
        self.identifStr = str;
        self.model = model;
        self.block = [block copy];
        sectionArr = [NSMutableArray array];
        rowArr = [NSMutableArray array];
        indexArr = [NSMutableArray array];
       
        
        for (CarBandSecondModel1 *model1 in self.model.datalist) {
            if ([model1.level isEqualToString:@"1"]) {
                [indexArr addObject:model1];
                if (sectionArr.count > 0) {
                    [rowArr addObject:sectionArr];
                    sectionArr = [NSMutableArray array];
                }
            } else if([model1.level isEqualToString:@"2"]){
                
                [sectionArr addObject:model1];
            }
            
        }
        [rowArr addObject:sectionArr];
    
    }
    
    return self;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YYLabel *label = [YYLabel new];
    label.displaysAsynchronously = YES;
    label.ignoreCommonProperties = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Create attributed string. ico_feileitiao
        NSString *str = [NSString stringWithFormat:@"%@", [[indexArr objectAtIndex:section] name]];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        text.font = [UIFont systemFontOfSize:14];
        text.color = [UIColor colorWithHexString:WORDCOLOR];

        
        // Create text container
        YYTextContainer *container = [YYTextContainer new];
        container.size = CGSizeMake(H(tableView), CGFLOAT_MAX);
        container.maximumNumberOfRows = 0;
        
        // Generate a text layout.

        
        dispatch_async(dispatch_get_main_queue(), ^{
            YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
            label.size = layout.textBoundingSize;
            label.textLayout = layout;
            label.origin = CGPointMake(10, 6);
        });
    });

     UIView *view = [UIView new];
     view.backgroundColor = RGB(245, 245, 249);
    UIImageView *imgView = [UIImageView new];
    [view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, screen_width-3));

    }];
     imgView.image = [UIImage imageNamed:@"ico_feileitiao"];
     [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return indexArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return [[rowArr objectAtIndex:section] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifStr forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    CarBandSecondModel1 *model1 = [[rowArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = model1.name;
    cell.textLabel.textColor = HEXCOLOR(0x333333);
    cell.textLabel.font = [UIFont systemFontOfSize:16];
  
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.block(rowArr, indexPath);
}

@end
