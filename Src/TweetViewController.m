//
//  TweetViewController.m
//  OAuthTwitterDemo
//
//  Created by Aran Mulholland on 26/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import "TweetViewController.h"


@implementation TweetViewController
@synthesize tweet, tweetWebView;


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

-(NSString *)processTweet {
	
	NSString *tweetString = [tweet objectForKey:@"text"];
	if (tweetString == nil) { }
	
	
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"/#([^ ]+)/"
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&error];
	
	NSArray *matches = [regex matchesInString:tweetString
									  options:0
										range:NSMakeRange(0, [tweetString length])];
	for (NSTextCheckingResult *match in matches) {
		NSRange matchRange = [match range];
		NSRange firstHalfRange = [match rangeAtIndex:1];
		NSRange secondHalfRange = [match rangeAtIndex:2];
	}
	
	NSString *returnValue = [NSString stringWithFormat:@"<html><head></head><body style=\"font-family: sans-serif;\">%@</body></html>", [tweet objectForKey:@"text"]];
	
	return returnValue;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *htmlString = [self processTweet];
	[tweetWebView loadHTMLString:htmlString baseURL:nil];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
	
}
												 												 
- (void)webViewDidFinishLoad:(UIWebView *)webView{
	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	
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
	[tweet release];
	[tweetWebView release];
    [super dealloc];
}


@end
