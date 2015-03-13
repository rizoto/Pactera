//
//  PCTFeedTableViewCell.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import "PCTFeedTableViewCell.h"
#import "PCTImageCache.h"

#define CELL_WIDTH ([[UIScreen mainScreen] bounds].size.width - 16)
#define CELL_HEIGHT ([[UIScreen mainScreen] bounds].size.height - 16)
#define CELL_MAX_HEIGHT 9999

CGSize textSizeUsingBlueFont(NSString * text) {
    return [text sizeWithFont:[UIFont fontWithName:BLUE_FONT_NAME size:BLUE_FONT_SIZE] constrainedToSize:CGSizeMake(CELL_WIDTH, CELL_MAX_HEIGHT) lineBreakMode:NSLineBreakByWordWrapping];
}

CGSize textSizeUsingBlackFont(NSString * text) {
    return [text sizeWithFont:[UIFont fontWithName:BLACK_FONT_NAME size:BLACK_FONT_SIZE] constrainedToSize:CGSizeMake(CELL_WIDTH * (2.f/3.f), CELL_MAX_HEIGHT) lineBreakMode:NSLineBreakByWordWrapping];
}

CGFloat imageHeight(NSString * stringUrl) {
    if ([[PCTImageCache sharedCache] objectForKey:stringUrl]) {
        UIImage *image = [[PCTImageCache sharedCache] objectForKey:stringUrl];
        if (image.size.width > 0) {
            return image.size.height * (((CELL_WIDTH * (1.f/3.f)) - 24) / image.size.width);
        }
    }
    return 0;
}

@implementation PCTFeedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    // create and add into the content view
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = BLUE_FONT;
        _titleLabel.textColor = [UIColor blueColor];
        [self.contentView addSubview:_titleLabel];
    }
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.font = BLACK_FONT;
        _descriptionLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_descriptionLabel];
    }
    if (!_pictureImageView) {
        _pictureImageView = [[PCTImageView alloc]init];
        [self.contentView addSubview:_pictureImageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat cell_width;
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) || (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)) {
        cell_width = CELL_WIDTH;
    } else {
        cell_width = CELL_HEIGHT;
    }
    
    // position subviews
    CGSize titleSize = textSizeUsingBlueFont(_titleLabel.text);
    CGRect frame = CGRectZero;
    frame.size = titleSize;
    frame.origin.x = 8;
    frame.origin.y = 8;
    _titleLabel.frame = frame;
    
    CGSize descriptionSize = textSizeUsingBlackFont(_descriptionLabel.text);
    frame = CGRectZero;
    frame.origin.x = 8;
    frame.origin.y += _titleLabel.frame.size.height + 8;
    frame.size = descriptionSize;
    _descriptionLabel.frame = frame;
    
    frame = CGRectZero;
    frame.origin.x = 8 + cell_width * (2.f/3.f);
    frame.origin.y += _titleLabel.frame.size.height + 8;
    frame.size.width = (cell_width * (1.f/3.f)) - 24;
    if (_pictureImageView.image.size.width > 0) {
        frame.size.height = _pictureImageView.image.size.height * (frame.size.width / _pictureImageView.image.size.width);
        _pictureImageView.frame = frame;
    }
}

@end
