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
	
	UIButton *characterCountButton;
	
	UIImageView *imageOne;
	UIImageView *imageTwo;
	UIImageView *imageThree;
	UIImageView *imageFour;
	UIImageView *imageFive;
	UIImageView *imageSix;
	UIImageView *imageSeven;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) NSDictionary *tweet;
@property (nonatomic, assign) id <TweetDelegate> tweetDelegate;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) IBOutlet UILabel *replyLabel;
@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;
@property (nonatomic, retain) IBOutlet UIButton *characterCountButton;

@property (nonatomic, retain) IBOutlet UIImageView *imageOne;
@property (nonatomic, retain) IBOutlet UIImageView *imageTwo;
@property (nonatomic, retain) IBOutlet UIImageView *imageThree;
@property (nonatomic, retain) IBOutlet UIImageView *imageFour;
@property (nonatomic, retain) IBOutlet UIImageView *imageFive;
@property (nonatomic, retain) IBOutlet UIImageView *imageSix;
@property (nonatomic, retain) IBOutlet UIImageView *imageSeven;

-(IBAction)close;
-(IBAction)send;

@end
