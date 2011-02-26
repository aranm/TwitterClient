//
//  TweetCell.h
//  TableViewLoadingTest
//
//  Created by Aran Mulholland on 23/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface TweetCell : UITableViewCell {
	EGOImageView *tweetImageView;
	UILabel *tweetLabel;
	UIButton *favouriteButton;
	UIButton *retweetButton;
	UIButton *replyButton;
}

@property (nonatomic, retain) IBOutlet EGOImageView *tweetImageView;
@property (nonatomic, retain) IBOutlet UILabel *tweetLabel;
@property (nonatomic, retain) IBOutlet UIButton *favouriteButton;
@property (nonatomic, retain) IBOutlet UIButton *retweetButton;
@property (nonatomic, retain) IBOutlet UIButton *replyButton;

-(IBAction)favouriteButtonPushed;
-(IBAction)retweetButtonPushed;
-(IBAction)replyButtonPushed;

-(void)setUserPhoto:(NSString*)userPhoto;

@end
