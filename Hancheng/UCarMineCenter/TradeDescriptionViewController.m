//
//  TradeDescriptionViewController.m
//  Hancheng
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TradeDescriptionViewController.h"

@interface TradeDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TradeDescriptionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"交易说明";

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"jiaoyishuoMing.html" withExtension:nil];
    NSString *htmlStr = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
    self.webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.webView];
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
