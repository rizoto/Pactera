//
//  PCTFeedRecord.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import "PCTFeedRecord.h"

@interface PCTFeedRecord()
@property (copy,nonatomic) NSDictionary *feed;
@end

@implementation PCTFeedRecord

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        _feed = dictionary;
    }
    return self;
}

- (NSString*)title {
    return _feed[@"title"];
}

- (NSString*)description {
    return _feed[@"description"];
}

- (NSString*)imageHref {
    return _feed[@"imageHref"];
}

@end
