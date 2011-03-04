//
//  TweetCell.m
//  TableViewLoadingTest
//
//  Created by Aran Mulholland on 23/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import "TweetCell.h"
#import "StringHelper.h"

@implementation TweetCell
@synthesize tweetImageView, tweetLabel, favouriteButton, retweetButton, replyButton, tweet, tweetDelegate, favouriteImageView, retweetedImageView, twitterIdLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

-(void)awakeFromNib{
	tweetImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder.png"]];
	tweetImageView.frame = CGRectMake(10.0f, 10.0f, 48.0f, 48.0f);	
	[self.contentView addSubview:tweetImageView];
	//[retweetedLabel setHidden:YES];
}

- (void)prepareForReuse {
	[self setTweet:nil];
	//[retweetedLabel setHidden:YES];
}

- (void)setUserPhoto:(NSString*)userPhoto {
	tweetImageView.imageURL = [NSURL URLWithString:userPhoto];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setFavouriteHighlight{
	if (tweet != nil){
		NSString *favoriteValue = [tweet objectForKey:@"favorited"];
		if ([favoriteValue compare:@"false"] == NSOrderedSame){
			[favouriteImageView setHighlighted:NO];			
		}
		else{
			[favouriteImageView setHighlighted:YES];			
		}
		
		
		NSString *retweetedValue = [tweet objectForKey:@"retweeted"];
		if ([retweetedValue compare:@"false"] == NSOrderedSame){
			[retweetedImageView setHighlighted:NO];			
		}
		else{
			[retweetedImageView setHighlighted:YES];			
		}
		
	}
}

-(void)setTweet:(NSDictionary *)value{
	[tweet release];
	tweet = value;
	[tweet retain];
	
	if (tweet != nil){
		
		NSString *sourceString = [tweet objectForKey:@"source"];
		
		//if ([sourceString rangeOfString:@"web"].location == NSNotFound) {
			[self setBackgroundColor:[UIColor redColor]];
		//}


		
		[self setFavouriteHighlight];
		NSString *tweetText = [tweet objectForKey:@"text"];
		[tweetLabel setText:tweetText];
		CGRect tweetLabelFrame = [tweetLabel frame];
		CGFloat heightOfLabel = [tweetText textHeightForSystemFontOfSize:16.0 withLabelWidth:tweetLabelFrame.size.width];
		[tweetLabel setFrame:CGRectMake(tweetLabelFrame.origin.x, tweetLabelFrame.origin.y, tweetLabelFrame.size.width, heightOfLabel)];
		
		//Calvin Drinkall
		//0416106546
		
		NSDictionary *retweeted = [tweet objectForKey:@"retweeted_status"];
		if (retweeted != nil && retweeted.count > 0){

			NSDictionary *userDetails = [tweet objectForKey:@"user"];
			NSDictionary *originalTweetUserDetails = [retweeted objectForKey:@"user"];
			
			//get the user details of the original tweeter
			NSString *retweetedScreenName = [originalTweetUserDetails objectForKey:@"screen_name"];			
			tweetImageView.imageURL = [NSURL URLWithString:[originalTweetUserDetails objectForKey:@"profile_image_url"]];
			
			
			//get the user details of the retweeter
			NSString *screenName = [userDetails objectForKey:@"screen_name"];
			
			//set the label sizes
			CGRect twitterIdLabelRect = [twitterIdLabel frame];
			CGFloat widthOfLabel = [screenName textWidthForSystemFontOfSize:17.0] + 15.0;
			CGRect newLabelFrame = CGRectMake(twitterIdLabelRect.origin.x, twitterIdLabelRect.origin.y, widthOfLabel, twitterIdLabelRect.size.height);
			[twitterIdLabel setFrame:newLabelFrame];

			CGFloat widthOfRetweetLabel = [retweetedScreenName textWidthForSystemFontOfSize:12.0];
			CGRect retweetLabelRect = CGRectMake(newLabelFrame.origin.x + widthOfLabel + 4, 6.0, widthOfRetweetLabel, 21.0);
			
			UILabel *retweetedLabel = [[UILabel alloc]initWithFrame:retweetLabelRect];
			[retweetedLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
			[retweetedLabel setFrame:retweetLabelRect];
			[retweetedLabel setText:screenName];
			[self addSubview:retweetedLabel];
			
			[twitterIdLabel setText:retweetedScreenName];
			
			[self setNeedsLayout];
		}
		else {
			NSDictionary *userDetails = [tweet objectForKey:@"user"];
			tweetImageView.imageURL = [NSURL URLWithString:[userDetails objectForKey:@"profile_image_url"]];
			NSString *screenName = [userDetails objectForKey:@"screen_name"];
			[twitterIdLabel setText:screenName];
			
			CGRect twitterIdLabelRect = [twitterIdLabel frame];
			CGFloat widthOfLabel = [screenName textWidthForSystemFontOfSize:17.0] + 15.0;
			CGRect newLabelFrame = CGRectMake(twitterIdLabelRect.origin.x, twitterIdLabelRect.origin.y, widthOfLabel, twitterIdLabelRect.size.height);
			[twitterIdLabel setFrame:newLabelFrame];
		}
	}
}

-(IBAction)favouriteButtonPushed{
	[favouriteImageView setHighlighted:![favouriteImageView isHighlighted]];	
	[tweetDelegate favouriteTweet:tweet];
}

-(IBAction)retweetButtonPushed{
	[retweetedImageView setHighlighted:![retweetedImageView isHighlighted]];
	[tweetDelegate retweet:tweet];
}

-(IBAction)replyButtonPushed{
	[tweetDelegate replyToTweet:tweet];
}


- (void)dealloc {
	tweetDelegate = nil;
	[tweet release];
	[tweetImageView release];
	[retweetedImageView release];
	[tweetLabel release];
	[twitterIdLabel release];
	[favouriteButton release];
	[retweetButton release];
	[replyButton release];
	[favouriteImageView release];
    [super dealloc];
}



@end
