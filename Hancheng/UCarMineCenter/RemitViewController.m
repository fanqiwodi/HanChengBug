//
//  RemitViewController.m
//  Hancheng
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RemitViewController.h"

@interface RemitViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RemitViewController
SettingBottomBar
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"汇款账号";
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"huikuan.html" withExtension:nil];
    NSString *htmlStr = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
    self.webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.webView];
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
