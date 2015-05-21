//
//  PCTFeedTableViewController.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#define kFeedCell   @"FeedCell"

#import "PCTFeedTableViewController.h"
#import "PCTImageCache.h"
#import "PCTFeedLoader.h"
#import "PCTFeedTableViewCell.h"
#import "PCTImageCacheTableViewController.h"

@interface PCTFeedTableViewController ()
{
    PCTFeedLoader   *_loader;
}
@end

@implementation PCTFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //testing title, should be rewritten after data loaded
    self.navigationItem.title = @"P A C T E R A";
    _loader = [[PCTFeedLoader alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataUpdated) name:kDataUpdated object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataImageUpdated) name:kImageUpdated object:nil];
    
    // register cell class
    [self.tableView registerClass:[PCTFeedTableViewCell class] forCellReuseIdentifier:kFeedCell];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // add reload button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadAll)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showImageCache)];
    
    
    // pull to refresh
    self.refreshControl = [[[UIRefreshControl alloc] init] autorelease];
    self.refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:@"Pull to Refresh"] autorelease];
    [self.refreshControl addTarget:self action:@selector(reloadAll) forControlEvents:UIControlEventValueChanged];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataUpdated object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kImageUpdated object:nil];
}

- (void)dataUpdated {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationItem.title = _loader.title;
        [self.tableView reloadData];
        if (self.refreshControl) {
            [self.refreshControl endRefreshing];
        }
    });
}

- (void)dataImageUpdated {
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self.tableView reloadData];
//        NSArray *cells = [self.tableView visibleCells];
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
//        for (PCTFeedTableViewCell* cell in cells) {
//            [cell.pictureImageView updateImageFromCache];
//        }
        for(NSIndexPath *indexPath in visiblePaths) {
            PCTFeedTableViewCell* cell = (id)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell.pictureImageView updateImageFromCache];
        }
    });
}

- (void)reloadAll {
    [_loader release];
    _loader = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationItem.title = @"P A C T E R A (Refresh)";
        [self.tableView reloadData];
    });
    //init new one
    _loader = [[PCTFeedLoader alloc] init];
    //clear cache
    [[PCTImageCache sharedCache]removeAllObjects];
    [[[PCTImageCache sharedCache] loadingURLs]removeAllObjects];
}

- (void)showImageCache {
    [self.navigationController pushViewController:[PCTImageCacheTableViewController new] animated:YES];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self dataUpdated];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_loader rows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCTFeedRecord *record = [_loader rowAtIndex:indexPath.row];
    return MAX(textSizeUsingBlackFont(record.description).height + textSizeUsingBlueFont(record.title).height + 24, textSizeUsingBlueFont(record.title).height + imageHeight(record.imageHref) + 16);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCTFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    // cell.layer.shouldRasterize = YES;
    
    // get data for the row
    PCTFeedRecord *record = [_loader rowAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    // configure cell
    cell.pictureImageView.urlString = @"";
    cell.pictureImageView.image = nil;
    cell.titleLabel.text = record.title;
    cell.descriptionLabel.text = record.description;
    cell.pictureImageView.urlString = record.imageHref;

    return cell;
}

- (void)dealloc {
    [_loader release];
    [super dealloc];
}


@end
