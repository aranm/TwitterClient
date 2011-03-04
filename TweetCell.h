//
//  TweetCell.h
//  TableViewLoadingTest
//
//  Created by Aran Mulholland on 23/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "TweetDelegate.h"

@interface TweetCell : UITableViewCell {
	EGOImageView *tweetImageView;
	UIImageView *favouriteImageView;
	UIImageView *retweetedImageView;
	UILabel *tweetLabel;
	UILabel *twitterIdLabel;

	UIButton *favouriteButton;
	UIButton *retweetButton;
	UIButton *replyButton;
	NSDictionary *tweet;
	id <TweetDelegate> tweetDelegate;
}

@property (nonatomic, retain) IBOutlet EGOImageView *tweetImageView;
@property (nonatomic, retain) IBOutlet UIImageView *favouriteImageView;
@property (nonatomic, retain) IBOutlet UIImageView *retweetedImageView;
@property (nonatomic, retain) IBOutlet UILabel *tweetLabel;
@property (nonatomic, retain) IBOutlet UILabel *twitterIdLabel;

@property (nonatomic, retain) IBOutlet UIButton *favouriteButton;
@property (nonatomic, retain) IBOutlet UIButton *retweetButton;
@property (nonatomic, retain) IBOutlet UIButton *replyButton;
@property (nonatomic, retain) NSDictionary *tweet;
@property(nonatomic,assign) id <TweetDelegate> tweetDelegate;

-(IBAction)favouriteButtonPushed;
-(IBAction)retweetButtonPushed;
-(IBAction)replyButtonPushed;

-(void)setUserPhoto:(NSString*)userPhoto;

@end