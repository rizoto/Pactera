//
//  PCTImageCacheTableViewController.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 21/05/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import "PCTImageCacheTableViewController.h"
#import "PCTImageCache.h"


static NSString *CellIdentifier = @"LazyTableCell";
static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";

@interface MyTableViewCell : UITableViewCell
@end
@implementation MyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // ignore the style argument and force the creation with style UITableViewCellStyleSubtitle
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}
@end

@interface PCTImageCacheTableViewController ()
{
    NSArray* keys;
}

@end

@implementation PCTImageCacheTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:PlaceholderCellIdentifier];
    keys = [[[PCTImageCache sharedCache] loadingURLs] allObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = keys[indexPath.row];
    cell.imageView.image = [[PCTImageCache sharedCache] objectForKey:keys[indexPath.row]];
    
    return cell;
}




@end
