//
//  ViewController.m
//  StateRestoration
//
//  Created by kishikawa katsumi on 2012/11/03.
//  Copyright (c) 2012年 kishikawa katsumi. All rights reserved.
//

#import "FirstTableViewController.h"

@interface FirstTableViewController ()

@end

@implementation FirstTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    return cell;
}

@end
