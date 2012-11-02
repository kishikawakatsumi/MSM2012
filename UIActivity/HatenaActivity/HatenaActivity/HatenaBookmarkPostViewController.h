//
//  HatenaBookmarkPostViewController.h
//  HatenaActivity
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012年 kishikawa katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthConsumer.h"

@interface HatenaBookmarkPostViewController : UIViewController

@property (strong, nonatomic) OAConsumer *consumer;
@property (strong, nonatomic) OAToken *accessToken;
@property (strong, nonatomic) NSURL *activityItem;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
