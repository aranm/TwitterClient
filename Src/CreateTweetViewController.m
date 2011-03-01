//
//  CreateTweetViewController.m
//  TwitterClient
//
//  Created by Aran Mulholland on 27/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import "CreateTweetViewController.h"


@implementation CreateTweetViewController
@synthesize textView, tweetDelegate, tweet, userName, replyLabel, userNameLabel, characterCountButton;
@synthesize imageOne, imageTwo, imageThree, imageFour, imageFive, imageSix, imageSeven;

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
	
	[textView becomeFirstResponder];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setLuckyImages:(int)luckiness {
	
	[imageOne setHidden:YES];
	[imageTwo setHidden:YES];
	[imageThree setHidden:YES];
	[imageFour setHidden:YES];
	[imageFive setHidden:YES];
	[imageSix setHidden:YES];
	[imageSeven setHidden:YES];
	
	switch (luckiness) {
		case 0:
			break;
		case 1:
			[imageTwo setHidden:NO];
			break;
		case 2:
			[imageFour setHidden:NO];
			break;
		case 3:
			[imageFour setHidden:NO];
			[imageFive setHidden:NO];
			break;
		case 4:
			[imageSix setHidden:NO];
			[imageTwo setHidden:NO];
			break;
		case 5:
			[imageFour setHidden:NO];
			[imageFive setHidden:NO];
			[imageSix setHidden:NO];
			break;		
		case 6:
			[imageOne setHidden:NO];
			[imageTwo setHidden:NO];
			[imageThree setHidden:NO];
			break;
		case 7:
			[imageOne setHidden:NO];
			[imageTwo setHidden:NO];
			[imageThree setHidden:NO];
			[imageFour setHidden:NO];
			[imageFive setHidden:NO];
			[imageSix setHidden:NO];
			[imageSeven setHidden:NO];
			break;
		default:
			break;
	}
	
}

- (void)textViewDidChange:(UITextView *)textView{
	
	int count = [[textView text] length];
	
	if (count > 140){
		count = 140 - count;
	}
	
	int luckiness = 0;
	
	for (int i = 0; i < count; i++){
		char character = [[textView text] characterAtIndex:i];
		luckiness += (int)character;
	}
	
	luckiness = luckiness % 8 + count % 8;
	
	[self setLuckyImages:luckiness];
	
	[characterCountButton setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
}

-(IBAction)close{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)sendTweetAndClose{
	[tweetDelegate sendTweet:[textView text] inReplyToTweet:tweet];
	[self close];
}

-(IBAction)send{
	if ([[textView text] length] > 140){
		// open a dialog with two custom buttons
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Tweet must be less than 140 characters"
																 delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
		[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
		[actionSheet release];
	}
	else {
		[self sendTweetAndClose];
	}
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
	[characterCountButton release];
	[imageOne release];
	[imageTwo release];
	[imageThree release]; 
	[imageFour release];
	[imageFive release];
	[imageSix release];
	[imageSeven release];
	
    [super dealloc];
}


@end
