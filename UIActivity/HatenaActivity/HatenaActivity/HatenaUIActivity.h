//
//  HatenaUIActivity.h
//  HatenaActivity
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012 kishikawa katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const HatenaUIActivityTypePostToHatenaBookmark;

@interface HatenaUIActivity : UIActivity

@property (strong, nonatomic) NSURL *activityItem;

@end
