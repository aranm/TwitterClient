//
//  OAuthTwitterDemoAppDelegate.h
//  OAuthTwitterDemo
//
//  Created by Ben Gottlieb on 7/24/09.
//  Copyright Stand Alone, Inc. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterFeedViewController;

@interface OAuthTwitterDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TwitterFeedViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TwitterFeedViewController *viewController;

@end

