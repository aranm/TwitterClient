//
//  CreateTweetViewController.h
//  TwitterClient
//
//  Created by Aran Mulholland on 27/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetDelegate.h"

@interface CreateTweetViewController : UIViewController <UITextViewDelegate> {
	UITextView *textView;
	id <TweetDelegate> tweetDelegate;
	NSDictionary *tweet;
	NSString *userName;
	
	UILabel *replyLabel;
	UILabel *userNameLabel;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) NSDictionary *tweet;
@property (nonatomic, assign) id <TweetDelegate> tweetDelegate;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) IBOutlet UILabel *replyLabel;
@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;

-(IBAction)close;
-(IBAction)send;

@end
