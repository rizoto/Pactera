//
//  AppDelegate.m
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import "AppDelegate.h"
#import "PCTNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // init window
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // create navigation view controller (including feed table viewcontroller) and make it rootViewController
    self.window.rootViewController = [[PCTNavigationController new] autorelease];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) dealloc {
    self.window.rootViewController = nil;
    [_window release];
    [super dealloc];
}



@end
