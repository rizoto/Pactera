//
//  PCTFeedLoader.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#define JSON_URL @"https://dl.dropboxusercontent.com/u/746330/facts.json"

#import "PCTFeedLoader.h"
#import "CJSONDeserializer.h"

@interface PCTFeedLoader()
{
    // holder of JSON
    NSMutableDictionary *_data;
}
@end

@implementation PCTFeedLoader

- (instancetype)init {
    self = [super init];
    if (self && !_data) {
        [self loadJSON];
    }
    return self;
}

- (void)loadJSON {
    // load data async
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        NSError *error;
        NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:JSON_URL]];
        if (!json) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kDataUpdated object:self];
            return;
        }
        NSString *jsonString = [NSString stringWithCString:[json bytes] encoding:NSASCIIStringEncoding];
        CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
        deserializer.nullObject = NULL;
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        _data = [[deserializer deserialize:jsonData error:&error] mutableCopy];
        NSMutableArray* array = [[_data[@"rows"] mutableCopy] autorelease];
        int j = 0;
        for (int i = 0; i < [_data[@"rows"] count]; i++, j++) {
            if ([_data[@"rows"][i] count] == 0) {
                [array removeObjectAtIndex:j--];
            }
        }
        [_data setObject:array forKey:@"rows"];
        // notify whoever listen
        [[NSNotificationCenter defaultCenter] postNotificationName:kDataUpdated object:self];
    });
}

- (NSUInteger)rows {
    return [_data[@"rows"] count];
}

- (NSString*)title {
    return _data[@"title"];
}

- (PCTFeedRecord*)rowAtIndex:(NSUInteger)index {
    if (self.rows < index) {
        return nil;
    }
    return [[[PCTFeedRecord alloc]initWithDictionary:_data[@"rows"][index]] autorelease];
}

- (void)dealloc {
    [super dealloc];
}


@end
