//
//  OAuthTwitterDemoAppDelegate.m
//  OAuthTwitterDemo
//
//  Created by Ben Gottlieb on 7/24/09.
//  Copyright Stand Alone, Inc. 2009. All rights reserved.
//

#import "OAuthTwitterDemoAppDelegate.h"
#import "TwitterFeedViewController.h"

@implementation OAuthTwitterDemoAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    

	TwitterFeedViewController *oAuthTwitterDemoViewController = [[TwitterFeedViewController alloc] initWithNibName:@"TwitterFeedViewController" bundle:nil];
	UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:oAuthTwitterDemoViewController];	
	
    // Override point for customization after app launch    
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
