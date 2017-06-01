//
//  LauchWebViewController.m
//  LanuchAdvertise
//
//  Created by polycom on 2017/6/1.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import "LauchWebViewController.h"

@interface LauchWebViewController ()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation LauchWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view addSubview:_webView];
    
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.scrollEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *path = @"http://www.ianisme.com";
    NSURL *url = [NSURL URLWithString:path];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
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
