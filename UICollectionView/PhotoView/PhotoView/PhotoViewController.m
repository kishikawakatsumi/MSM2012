//
//  PhotoViewController.m
//  PhotoView
//
//  Created by kishikawa katsumi on 2012/11/01.
//
//

#import "PhotoViewController.h"
#import "ThumbnailCell.h"

@interface PhotoViewController ()
{
    ALAssetsLibrary *library;
    NSMutableArray *assets;
}

@end

@implementation PhotoViewController

- (void)awakeFromNib
{
    library = [[ALAssetsLibrary alloc] init];
    assets = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat topInset = self.navigationController.navigationBar.bounds.size.height + statusBarFrame.size.height;
    self.collectionView.contentInset = UIEdgeInsetsMake(topInset, 0.0f, 0.0f, 0.0f);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(topInset, 0.0f, 0.0f, 0.0f);
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop)
          {
              if (result) {
                  dispatch_async(dispatch_get_main_queue(), ^
                                 {
                                     [assets addObject:result];
                                     [self.collectionView reloadData];
                                 });
              }
          }];
     } failureBlock:^(NSError *error)
     {
         NSLog(@"%@", error.localizedDescription);
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGRect statusBarFrame = [self statusBarFrame];
    CGFloat topInset = self.navigationController.navigationBar.bounds.size.height + statusBarFrame.size.height;
    self.collectionView.contentInset = UIEdgeInsetsMake(topInset, 0.0f, 0.0f, 0.0f);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(topInset, 0.0f, 0.0f, 0.0f);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [assets objectAtIndex:indexPath.row];
    UIImage *thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
    
    ThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbnailCell" forIndexPath:indexPath];
    [cell.imageButton setImage:thumbnail forState:UIControlStateNormal];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGRect)statusBarFrame
{
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *keyWindow = app.keyWindow;
    CGRect statusBarFrame = app.statusBarFrame;
    CGRect statusBarWindowRect = [keyWindow convertRect:statusBarFrame fromWindow: nil];
    CGRect statusBarViewRect = [self.view convertRect:statusBarWindowRect fromView: nil];
    return statusBarViewRect;
}

@end
