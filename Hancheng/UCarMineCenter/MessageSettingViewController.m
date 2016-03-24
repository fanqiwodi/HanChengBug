//
//  MessageSettingViewController.m
//  Hancheng
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageSettingViewController.h"

@interface MessageSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@end

@implementation MessageSettingViewController

SettingBottomBar

- (void)getNetData
{
    WS(myself);
    GetWithHeaderAPI *API = [[GetWithHeaderAPI alloc]initWithUrl:@"/api/ucarMy/getPush" header:@{@"uid":[UserMangerDefaults UidGet]}];
    [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
      NSNumber *num = request.responseBody[@"data"][@"is_push"];
        if ([num isEqualToNumber:@0]) {
            myself.mySwitch.on = YES;
        } else {
            myself.mySwitch.on = NO;
        }
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"错误%lu", request.responseStatusCode);
    }];
}


- (IBAction)turnAction:(id)sender {
    UISwitch *s = sender;
    s.userInteractionEnabled = NO;
    NSDictionary *param = @{@"isPush":s.on ? @0 : @1};
    PutWithHeaderAPI *API = [[PutWithHeaderAPI alloc] initWith:param urlStr:@"/api/ucarMy/ediPush" header:@{@"Uid":[UserMangerDefaults UidGet]}];
    //获取concurrent queue
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建1个queue group
    dispatch_group_t queueGroup = dispatch_group_create();
    //任务1
    dispatch_group_async(queueGroup, aQueue, ^{
        NSLog(@"task 1.");
      
        [API startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            NSLog(@"--%@--", request.responseBody[@"msg"]);
        } failure:^(YTKBaseRequest *request) {
            NSLog(@"错误%lu", request.responseStatusCode);
        }];
    });
 

    dispatch_group_notify(queueGroup, dispatch_get_main_queue(), ^{
        s.userInteractionEnabled = YES;

    });
   
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];

    [self getNetData];
    self.title = @"消息推送";

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
