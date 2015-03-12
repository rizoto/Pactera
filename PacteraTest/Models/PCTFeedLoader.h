//
//  PCTFeedLoader.h
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#define kDataUpdated    @"kDataUpdated"

#import <Foundation/Foundation.h>
#import "PCTFeedRecord.h"

@interface PCTFeedLoader : NSObject

// return rows and title from Json
- (NSUInteger)rows;
- (NSString*)title;

// return feed record object
- (PCTFeedRecord*)rowAtIndex:(NSUInteger)index;

@end
