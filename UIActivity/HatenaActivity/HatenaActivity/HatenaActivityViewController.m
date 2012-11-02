//
//  HatenaActivityViewController.m
//  HatenaActivity
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012 kishikawa katsumi. All rights reserved.
//

#import "HatenaActivityViewController.h"
#import "HatenaBookmarkPostViewController.h"
#import "OAuthConsumer.h"

#define CONSUMER_KEY @"damDGgMhdE8pqg=="
#define CONSUMER_SECRET @"8gPBDj/QHDDe4mY49NZ5Tiyj58c="

@interface HatenaActivityViewController () <UIWebViewDelegate> {
    OAConsumer *consumer;
    OAToken *requestToken;
    OAToken *accessToken;
    NSURL *authorizeCallbackURL;
}

@end

@implementation HatenaActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    authorizeCallbackURL = [NSURL URLWithString:@"http://kishikawakatsumi.com/"];
    
    consumer = [[OAConsumer alloc] initWithKey:CONSUMER_KEY secret:CONSUMER_SECRET];
    [self tokenRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (void)tokenRequest {
    NSURL *requestTokenURL = [NSURL URLWithString:@"https://www.hatena.com/oauth/initiate"];
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:requestTokenURL
                                                                   consumer:consumer
                                                                      token:nil
                                                                      realm:nil
                                                          signatureProvider:nil];
	[request setHTTPMethod:@"POST"];
    
    [request setOAuthParameterName:@"oauth_callback" withValue:authorizeCallbackURL.absoluteString];
    request.parameters = @[[OARequestParameter requestParameterWithName:@"scope" value:@"write_public,write_private"]];
	
    OAAsynchronousDataFetcher *fetcher = [OAAsynchronousDataFetcher asynchronousFetcherWithRequest:request
                                                                                          delegate:self
                                                                                 didFinishSelector:@selector(tokenRequestTicket:didFinishWithData:)
                                                                                   didFailSelector:@selector(tokenRequestTicket:didFailWithError:)];
	[fetcher start];
}

#pragma mark -

- (void)tokenRequestTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
	if (ticket.didSucceed) {
		NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		OAToken *token = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
        requestToken = token;
		
		[self tokenAuthorize];
	}
}

- (void)tokenRequestTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error {
	NSLog(@"Getting request token failed: %@", [error localizedDescription]);
}

#pragma mark -

- (void)tokenAuthorize
{
    NSURL *authorizeURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.hatena.ne.jp/touch/oauth/authorize?oauth_token=%@", requestToken.key]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:authorizeURL];
    request.HTTPShouldHandleCookies = NO;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:authorizeURL]];
}

#pragma mark -

- (void)tokenAccessWithVerifier:(NSString *)verifier
{
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.hatena.com/oauth/token"]
                                                                   consumer:consumer
                                                                      token:requestToken
                                                                      realm:nil
                                                          signatureProvider:nil];
	
    [request setHTTPMethod:@"POST"];
    [request setOAuthParameterName:@"oauth_verifier" withValue:verifier];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(tokenAccessTicket:didFinishWithData:)
                  didFailSelector:@selector(tokenAccessTicket:didFailWithError:)];
}

- (void)tokenAccessTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data
{
	if (ticket.didSucceed)
	{
		NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		accessToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        
        HatenaBookmarkPostViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"HatenaBookmarkPostViewController"];
        controller.consumer = consumer;
        controller.accessToken = accessToken;
        controller.activityItem = _activityItem;
        
        [self.navigationController pushViewController:controller animated:YES];
	}
}

- (void)tokenAccessTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error
{
	NSLog(@"Getting access token failed: %@", [error localizedDescription]);
}

#pragma mark -

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	if ([request.URL.absoluteString rangeOfString:authorizeCallbackURL.absoluteString options:NSCaseInsensitiveSearch].location != NSNotFound) {
		NSMutableDictionary *queryParams = [NSMutableDictionary dictionary];
		if (request.URL.query != nil) {
			NSArray *vars = [request.URL.query componentsSeparatedByString:@"&"];
			for(NSString *var in vars) {
				NSArray *parts = [var componentsSeparatedByString:@"="];
				if (parts.count == 2) {
					[queryParams setObject:[parts objectAtIndex:1] forKey:[parts objectAtIndex:0]];
                }
			}
		}
        
        [self tokenAccessWithVerifier:[queryParams objectForKey:@"oauth_verifier"]];
        
		return NO;
	}
	
	return YES;
}

@end
