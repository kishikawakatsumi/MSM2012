//
//  HatenaBookmarkPostViewController.m
//  HatenaActivity
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012年 kishikawa katsumi. All rights reserved.
//

#import "HatenaBookmarkPostViewController.h"

@interface HatenaBookmarkPostViewController ()

@end

@implementation HatenaBookmarkPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
- (IBAction)done:(id)sender
{
    if (_activityItem) {
        OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://b.hatena.ne.jp/atom/post"]
                                                                       consumer:_consumer
                                                                          token:_accessToken
                                                                          realm:nil
                                                              signatureProvider:nil];
        [request setHTTPMethod:@"POST"];
        [request prepare];
        
        NSString *body = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                          @"<entry xmlns=\"http://purl.org/atom/ns#\">"
                          @"<link rel=\"related\" type=\"text/html\" href=\"%@\" />"
                          @"<summary type=\"text/plain\">%@</summary>"
                          @"</entry>", _activityItem.absoluteString, _textField.text ?: @""];
        
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [request setValue:@"text/xml;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        
        OAAsynchronousDataFetcher *fetcher = [OAAsynchronousDataFetcher asynchronousFetcherWithRequest:request
                                                                                              delegate:self
                                                                                     didFinishSelector:@selector(sendTicket:didFinishWithData:)
                                                                                       didFailSelector:@selector(sendTicket:didFailWithError:)];
        [fetcher start];
    }
}

- (void)sendTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data
{
    if (ticket.didSucceed && ticket.response.statusCode == 201) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)sendTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

@end
