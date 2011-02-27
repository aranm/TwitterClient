//
//  TwitterFeedViewController.h
//  OAuthTwitterDemo
//
//  Created by Ben Gottlieb on 7/24/09.
//  Copyright Stand Alone, Inc. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"
#import "EGORefreshTableHeaderView.h"
#import "TweetDelegate.h"

@class SA_OAuthTwitterEngine;

@interface TwitterFeedViewController : UIViewController <SA_OAuthTwitterControllerDelegate, UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate, TweetDelegate> {
	SA_OAuthTwitterEngine *_engine;
	UITableView *feedTableView;
	
	NSMutableArray *timeLineTweets;
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
	NSDate *lastUpdatedTime;
}

@property (nonatomic, retain) IBOutlet UITableView *feedTableView;
@property (nonatomic, retain) NSMutableArray *timeLineTweets;

-(IBAction)refreshFeed;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end

