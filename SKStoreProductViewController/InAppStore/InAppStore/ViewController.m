//
//  ViewController.m
//  InAppStore
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012 kishikawa katsumi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)openStore:(id)sender
{
    SKStoreProductViewController *controller = [[SKStoreProductViewController alloc] init];
    controller.delegate = self;
    [controller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"290464595"}
                          completionBlock:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
