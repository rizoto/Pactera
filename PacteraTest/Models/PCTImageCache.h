//
//  PCTImageCache.h
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCTImageCache : NSCache

@property (strong,atomic) NSMutableSet* loadingURLs;

+ (id)sharedCache;

@end
