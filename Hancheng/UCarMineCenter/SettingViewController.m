//
//  SettingViewController.m
//  Hancheng
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangePwdViewController.h"
#import "MessageSettingViewController.h"
#import "PosterViewController.h"
#import "XGPush.h"
#import "UCarLoginViewController.h"
#import "BaseNavigationViewController.h"
#import "DBHelper.h"
#import "LGAlertView.h"
#import "AboutUsViewController.h"
@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *dataDic;
    FMDatabase *db;
    UILabel *cacheLabel;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation SettingViewController

// logout

- (BOOL)deleteDatabse
{
    BOOL success = NO;
    NSError *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // delete the old db.
    
    if ([fileManager fileExistsAtPath:RETURNPATH(@"systemNoti.db")])
    {
        db = [DBHelper getDataBase:@"systemNoti.db"];
        if ( [db close]) {
            success = [fileManager removeItemAtPath:RETURNPATH(@"systemNoti.db") error:&error];
            [fileManager removeItemAtPath:RETURNPATH(@"PersonInfo.db") error:&error];
            if (!success) {
                NSAssert1(0, @"Failed to delete old database file with message '%@'.", [error localizedDescription]);
            }
        }
        
    }
    NSLog(@"ifReadOnly value: %@" ,success ? @"YES":@"NO");
    return success;
}


- (IBAction)logoutAction:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"确定要退出吗?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UCARNSUSERDEFULTS(userDefaults)
        [userDefaults removeObjectForKey:GETUID];
        [userDefaults setBool:NO forKey:IS_LOGIN];
        [userDefaults synchronize];
        //删除沙盒文件
        NSFileManager* fileManager=[NSFileManager defaultManager];
        BOOL deleteBoll = [fileManager removeItemAtPath: RETURNPATH(@"modelc58.model") error:nil];
        
        
        [self deleteDatabse];
        
        if (deleteBoll) {
            [XGPush unRegisterDevice];
            
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:CENTERLOGOUT object:nil];
        }
    }
}

- (void)initTableView
{
    dataDic = @{@"0":@[@"修改密码", @"消息设置"], @"1": @[@"清除缓存数据"], @"2":@[@"吐槽U车库", @"关于U车库"]};
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.myTableView.separatorColor = [UIColor colorWithHexString:LINECOLOR];
   [self.myTableView setTableFooterView:[UIView new]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23*REM;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[dataDic allKeys] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionStr = [NSString stringWithFormat:@"%lu", section];
    return [dataDic[sectionStr] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSString *sectioStr = [NSString stringWithFormat:@"%lu", indexPath.section];
    cell.textLabel.text = [dataDic[sectioStr] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    if (indexPath.section == 1 && indexPath.row == 0) {
            cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300*REM, 55*REM)];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cachesDir = [paths objectAtIndex:0];
            
            NSString *str = [NSString stringWithFormat:@"%.2lfMB", [self folderSizeAtPath:cachesDir]];
            cacheLabel.text = str;
            cacheLabel.font = [UIFont systemFontOfSize:15];
            cacheLabel.textAlignment = 2;
            cacheLabel.font = [UIFont systemFontOfSize:15];
            cacheLabel.textColor = [UIColor colorWithHexString:@"333333"];
            cell.accessoryView =  cacheLabel;

    } else {
      
        if (cell.accessoryView != nil) {
            cell.accessoryView = [UIView new];
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ChangePwdViewController *pwdVC = [[ChangePwdViewController alloc]init];
        [self.navigationController pushViewController:pwdVC animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        MessageSettingViewController *msgSettingVC = [[MessageSettingViewController alloc] init];
        [self.navigationController pushViewController:msgSettingVC animated:YES];
    }
    if (indexPath.section == 1) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDir = [paths objectAtIndex:0];
        NSFileManager* fm = [NSFileManager defaultManager];

        if([fm fileExistsAtPath:cachesDir]){
           NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:cachesDir];
            NSString *path;
            while ((path = [dirEnum nextObject]) != nil)
            {
                NSError *error;
                NSString *delelteFilePath = [cachesDir stringByAppendingPathComponent:path];
                if ([fm removeItemAtPath:delelteFilePath error:&error] != YES)
                {
                    NSLog(@"错误");
                } else {
                    [tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationFade];
                }
                
            }
           
        }
    }
    
    if (indexPath.section == 2 & indexPath.row == 0) {
        PosterViewController *posterVC = [[PosterViewController alloc] init];
        [self.navigationController pushViewController:posterVC animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController: aboutVC animated:YES];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];
    self.title = @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma privateMethod
// 判断文件总大小
- (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1000.0*1000.0);
    
}


//单个文件的大小

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
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
