//
//  TweetCell.m
//  TableViewLoadingTest
//
//  Created by Aran Mulholland on 23/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import "TweetCell.h"


@implementation TweetCell
@synthesize tweetImageView, tweetLabel, favouriteButton, retweetButton, replyButton;

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

- (void)setUserPhoto:(NSString*)userPhoto {
	tweetImageView.imageURL = [NSURL URLWithString:userPhoto];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

-(IBAction)favouriteButtonPushed{
	
	
}

-(IBAction)retweetButtonPushed{
	
	
}

-(IBAction)replyButtonPushed{
	
	
}


- (void)dealloc {
	[tweetImageView release];
	[tweetLabel release];
	[favouriteButton release];
	[retweetButton release];
	[replyButton release];
    [super dealloc];
}



@end
