//
//  PCTImageView.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import "PCTImageView.h"
#import "PCTFeedLoader.h"
#import "PCTImageCache.h"

@implementation PCTImageView

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    self.image = nil;
    self.frame = CGRectZero;
    if (urlString && urlString.length > 0) {
        [self loadData];
    }
}

- (void)loadData {
    // load data async or from cache
    if ([[PCTImageCache sharedCache] objectForKey:_urlString]) {
        self.image = [[PCTImageCache sharedCache] objectForKey:_urlString];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            @synchronized([[PCTImageCache sharedCache] loadingURLs]) {
                if ([[[PCTImageCache sharedCache] loadingURLs] containsObject:_urlString]) {
                    return;
                } else {
                    [[[PCTImageCache sharedCache] loadingURLs] addObject:_urlString];
                }
            }
            NSLog(@"Loading: %@",_urlString);
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_urlString]];
            UIImage *image = [UIImage imageWithData:imageData];
            if (image) {
                [[PCTImageCache sharedCache]setObject:image forKey:_urlString];
                self.image = image;
                NSLog(@"Loaded: %@",_urlString);
                [[NSNotificationCenter defaultCenter] postNotificationName:kImageUpdated object:nil];
            }
        });
    }
}

- (void)updateImageFromCache {
    if ([[PCTImageCache sharedCache] objectForKey:_urlString]) {
        self.image = [[PCTImageCache sharedCache] objectForKey:_urlString];
    }
}

- (void)dealloc {
    self.image = nil;
    [super dealloc];
}

@end
