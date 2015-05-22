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
            // to save image for correct url
            NSString* _urlStringCopy = [[_urlString copy] autorelease];
            @synchronized([[PCTImageCache sharedCache] loadingURLs]) {
                if ([[[PCTImageCache sharedCache] loadingURLs] containsObject:_urlStringCopy]) {
                    return;
                } else {
                    [[[PCTImageCache sharedCache] loadingURLs] addObject:_urlStringCopy];
                }
            }
            NSLog(@"Loading: %@,%p",_urlStringCopy,self);
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_urlStringCopy]];
            UIImage *image = [UIImage imageWithData:imageData];
            if (image) {
                [[PCTImageCache sharedCache]setObject:image forKey:_urlStringCopy];
                //self.image = image;
                NSLog(@"Loaded: %@,%p",_urlStringCopy,self);
                [[NSNotificationCenter defaultCenter] postNotificationName:kImageUpdated object:nil userInfo:@{@"urlString":_urlStringCopy}];
            }
        });
    }
}

- (void)updateImageFromCache {
    UIImage* image ;
    if ([[PCTImageCache sharedCache] objectForKey:_urlString]) {
        image = [[PCTImageCache sharedCache] objectForKey:_urlString];
        self.image = image;
        //[self.superview setNeedsLayout];
    }
}

- (void)dealloc {
    self.image = nil;
    [super dealloc];
}

@end
