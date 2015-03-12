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
    
    // register cell class
    [self.tableView registerClass:[PCTFeedTableViewCell class] forCellReuseIdentifier:kFeedCell];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataUpdated object:nil];
}

- (void)dataUpdated {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationItem.title = _loader.title;
        [self.tableView reloadData];
    });
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
    
    // get data for the row
    PCTFeedRecord *record = [_loader rowAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    // configure cell
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
