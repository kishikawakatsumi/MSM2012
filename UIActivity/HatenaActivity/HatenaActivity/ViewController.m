//
//  ViewController.m
//  HatenaActivity
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012 kishikawa katsumi. All rights reserved.
//

#import "ViewController.h"
#import "HatenaUIActivity.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://kishikawakatsumi.com/"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)shareAction:(id)sender
{
    NSURL *mainDocumentURL = _webView.request.mainDocumentURL;
    NSArray *activityItems = @[mainDocumentURL];
    
    HatenaUIActivity *activity = [[HatenaUIActivity alloc] init];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[activity]];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _shareButton.enabled = YES;
}

@end
