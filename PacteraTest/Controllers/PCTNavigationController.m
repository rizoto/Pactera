//
//  PCTNavigationController.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import "PCTNavigationController.h"
#import "PCTFeedTableViewController.h"

@interface PCTNavigationController ()

@end

@implementation PCTNavigationController

- (instancetype)init {
    return [super initWithRootViewController:[[PCTFeedTableViewController new] autorelease]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}



@end
