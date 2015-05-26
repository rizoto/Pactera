//
//  PCTImageViewController.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 25/05/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import "PCTImageViewController.h"

@interface PCTImageViewController ()

@end

@implementation PCTImageViewController
{
    UIView* previousSuperview;
    UIView* borrowedView;
    CGRect previousFrame, absolutePosition;
}

- (instancetype)initWithView:(UIView*)view {
    self = [super init];
    if (self) {
        //borrowedView = [UIImageView alloc]initWithImage:(view)
        //view.frame = CGRectMake(100, 100, 100, 100);
        //[self.view addSubview:view];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
