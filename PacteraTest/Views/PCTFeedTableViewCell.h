//
//  PCTFeedTableViewCell.h
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "PCTImageView.h"

#define BLUE_FONT_NAME @"Times New Roman"
#define BLUE_FONT_SIZE 18.f
#define BLACK_FONT_NAME @"Helvetica"
#define BLACK_FONT_SIZE 16.f
#define BLUE_FONT [UIFont fontWithName:@"Times New Roman" size:18.f]
#define BLACK_FONT [UIFont fontWithName:@"Helvetica" size:16.f]

// helper functions to calculate different sizes and height
CGSize textSizeUsingBlueFont(NSString * text);
CGSize textSizeUsingBlackFont(NSString * text);
CGFloat imageHeight(NSString * stringUrl);

@interface PCTFeedTableViewCell : UITableViewCell

@property (retain,nonatomic)    UILabel *titleLabel;
@property (retain,nonatomic)    UILabel *descriptionLabel;
@property (retain,nonatomic)    PCTImageView* pictureImageView;
@property (copy,nonatomic)      NSString* imageHref;

@end
