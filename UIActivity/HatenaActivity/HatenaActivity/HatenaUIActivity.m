//
//  HatenaUIActivity.m
//  HatenaActivity
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012 kishikawa katsumi. All rights reserved.
//

#import "HatenaUIActivity.h"
#import "HatenaActivityViewController.h"

NSString *const HatenaUIActivityTypePostToHatenaBookmark = @"HatenaUIActivityTypePostToHatenaBookmark";

@implementation HatenaUIActivity

- (NSString *)activityType {
    return HatenaUIActivityTypePostToHatenaBookmark;
}

- (NSString *)activityTitle {
    return @"Hatena Bookmark";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"ActivityIcon"];
}

- (UIViewController *)activityViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"HatenaActivityViewController"];
    
    HatenaActivityViewController *controller = navigationController.viewControllers[0];
    controller.activityItem = _activityItem;
    
    return navigationController;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSURL class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSURL class]]) {
            self.activityItem = item;
        }
    }
}

@end
