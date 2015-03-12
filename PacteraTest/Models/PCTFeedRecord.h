//
//  PCTFeedRecord.h
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCTFeedRecord : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

- (NSString*)title;
- (NSString*)description;
- (NSString*)imageHref;

@end
