//
//  TweetCell.m
//  TableViewLoadingTest
//
//  Created by Aran Mulholland on 23/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import "TweetCell.h"


@implementation TweetCell
@synthesize tweetImageView, tweetLabel, favouriteButton, retweetButton, replyButton, tweet, tweetDelegate, favouriteImageView, retweetedImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

-(void)awakeFromNib{
	tweetImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder.png"]];
	tweetImageView.frame = CGRectMake(14.0f, 14.0f, 68.0f, 68.0f);
	[self.contentView addSubview:tweetImageView];
}

- (void)prepareForReuse {
	[self setTweet:nil];
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
		
		if ([sourceString rangeOfString:@"web"].location == NSNotFound) {
			[self setBackgroundColor:[UIColor redColor]];
		}

		[self setFavouriteHighlight];
		
		[tweetLabel setText:[tweet objectForKey:@"text"]];
		
		NSDictionary *userDetails = [tweet objectForKey:@"user"];
		tweetImageView.imageURL = [NSURL URLWithString:[userDetails objectForKey:@"profile_image_url"]];
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
	[favouriteButton release];
	[retweetButton release];
	[replyButton release];
	[favouriteImageView release];
    [super dealloc];
}



@end
