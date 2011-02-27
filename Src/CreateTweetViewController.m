//
//  CreateTweetViewController.m
//  TwitterClient
//
//  Created by Aran Mulholland on 27/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import "CreateTweetViewController.h"


@implementation CreateTweetViewController
@synthesize textView, tweetDelegate, tweet, userName, replyLabel, userNameLabel;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if (tweet != nil) {
		NSDictionary *user = [tweet objectForKey:@"user"];
		NSString *inreplyToUserName = [NSString stringWithFormat:@"@%@ ", [user objectForKey:@"screen_name"]];
		[textView setText:inreplyToUserName];
		[replyLabel setText:[NSString stringWithFormat:@"In reply to %@", inreplyToUserName]];
	}
	else{
		[textView setText:@""];	
		[replyLabel setText:@"New Tweet"];
	}
	[userNameLabel setText:[NSString stringWithFormat:@"@%@", userName]];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)textViewDidChange:(UITextView *)textView{
	
}

-(IBAction)close{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)send{
	[tweetDelegate sendTweet:[textView text] inReplyToTweet:tweet];
	[self dismissModalViewControllerAnimated:YES];	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	tweetDelegate = nil;
	[replyLabel release];
	[userNameLabel release];
	[tweet release];
	[textView release];
	[userName release];
    [super dealloc];
}


@end
