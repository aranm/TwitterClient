//
//  TweetViewController.h
//  OAuthTwitterDemo
//
//  Created by Aran Mulholland on 26/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TweetViewController : UIViewController <UIWebViewDelegate> {

	NSDictionary *tweet;
	UIWebView *tweetWebView;
}

@property (nonatomic, retain) NSDictionary *tweet;
@property (nonatomic ,retain) IBOutlet UIWebView *tweetWebView;
@end
