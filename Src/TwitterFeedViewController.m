//
//  TwitterFeedViewController.m
//  OAuthTwitterDemo
//
//  Created by Ben Gottlieb on 7/24/09.
//  Copyright Stand Alone, Inc. 2009. All rights reserved.
//

#import "TwitterFeedViewController.h"
#import "SA_OAuthTwitterEngine.h"
#import "TweetCell.h"
#import "TweetViewController.h"
#import "CreateTweetViewController.h"
#import "StringHelper.h"

#define kOAuthConsumerKey       @"nERCkXJhQecs15zpnzMrw"
#define kOAuthConsumerSecret    @"vO1zEHZCAWyCu8zWF4T0kxH8gRwIarNDKJWE7Hp1jk"

@implementation TwitterFeedViewController
@synthesize feedTableView, timeLineTweets;

#pragma mark -
#pragma mark SA_OAuthTwitterEngineDelegate

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];

	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

#pragma mark -
#pragma mark SA_OAuthTwitterControllerDelegate

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	NSLog(@"Authenicated for %@", username);
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
}

#pragma mark -
#pragma mark TwitterEngineDelegate

- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
	[self doneLoadingTableViewData];
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
	[self doneLoadingTableViewData];
}

-(int)updateTweetInTimeLine:(NSDictionary *)tweet{

	NSString *tweetId = [tweet objectForKey:@"id"];
	
	int rowCount = 0;
	BOOL replaced = NO;
	
	for (rowCount = 0; rowCount < timeLineTweets.count && replaced == NO; rowCount++){
		NSDictionary *tweetInTimeLine = (NSDictionary *)[timeLineTweets objectAtIndex:rowCount];
		NSString *tweetInTimeLineId = [tweetInTimeLine objectForKey:@"id"];
		
		if ([tweetInTimeLineId compare:tweetId] == NSOrderedSame){
			NSLog(@"----********-------");
		//	NSLog(tweetInTimeLine);
			NSLog(@"----********-------");
			//replaced = YES;
			//[timeLineTweets replaceObjectAtIndex:rowCount withObject:tweet];
		}
	}
	
	if (replaced == NO){
		rowCount = -1;
	}
	
	return rowCount;
}

- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)identifier {
	
	NSMutableArray *insertedIndexPaths = [[NSMutableArray alloc]init];
	
	for (int i = 0; i < statuses.count; i++){
		
		NSDictionary *dictionary = (NSDictionary *)[statuses objectAtIndex:i];
		
		int row = [self updateTweetInTimeLine:dictionary];
		
		if (row != -1) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row - 1 inSection:0];
			[feedTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
		else {
			[timeLineTweets addObject:dictionary];
			//[timeLineTweets insertObject:dictionary atIndex:0];
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
			[insertedIndexPaths addObject:indexPath];
		}
		
		NSString *key;
		for (key in dictionary) {
			NSLog(@"Key: %@ Value: %@", key, [dictionary objectForKey:key]);
		}
		
		NSLog(@"-----------------------------------------------------------------------");
	}
	if (insertedIndexPaths.count > 0){
		[feedTableView insertRowsAtIndexPaths:insertedIndexPaths withRowAnimation:UITableViewRowAnimationFade];
	}
	
	[insertedIndexPaths release];
	
	[self doneLoadingTableViewData];
}
- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)identifier { }
- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)identifier { }

#pragma mark -
#pragma mark Table view data source


-(TweetCell *)getTweetCell {
	
	NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TweetCell" owner:nil options:nil];
	return (TweetCell *)[topLevelObjects objectAtIndex:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return timeLineTweets.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


   static NSString *CellIdentifier = @"TweetCell";
    
    TweetCell *cell = (TweetCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self getTweetCell];
    }
    
	NSDictionary *tweetItem = [timeLineTweets objectAtIndex:indexPath.row];
	[cell setTweet:tweetItem];
	[cell setTweetDelegate:self];
	
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *tweetItem = [timeLineTweets objectAtIndex:indexPath.row];
	NSString *tweetText = [tweetItem objectForKey:@"text"];
	
	CGFloat heightOfLabel = [tweetText textHeightForSystemFontOfSize:16.0 withLabelWidth:204.0];
	
	CGFloat totalHeightOfCell = heightOfLabel + 60.0;
	
	if (totalHeightOfCell < 110.0){
		totalHeightOfCell = 110.0;
	}
	
	return totalHeightOfCell;	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
	TweetViewController *detailViewController = [[TweetViewController alloc] initWithNibName:@"TweetViewController" bundle:nil];
	// ...
	NSDictionary *tweetItem = [timeLineTweets objectAtIndex:indexPath.row];
	[detailViewController setTweet:tweetItem];
	 // Pass the selected object to the new view controller.
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];	
}

#pragma mark -
#pragma mark User Interaction

-(IBAction)refreshFeed {
	if (_engine == nil) { }
	else if ([_engine isAuthorized] == NO) { }
	else{
		NSLog(@"%@", [_engine getFollowedTimelineSinceID:0 startingAtPage:0 count:100]);
		//[_engine getPublicTimeline];
	}
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.feedTableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self refreshFeed];
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark TweetDelegate

- (void)favouriteTweet:(NSDictionary *)tweet {
	
	BOOL favourite = NO;
	
	NSString *favoriteValue = [tweet objectForKey:@"favorited"];
	if ([favoriteValue compare:@"true"] == NSOrderedSame){
		favourite = YES;	
	}
	
	NSString *stringID = [tweet objectForKey:@"id"];
	NSString *favId = [_engine markUpdateUsingString:stringID asFavorite:!favourite];
}

- (void)retweet:(NSDictionary *)tweet {
	[_engine retweet:[tweet objectForKey:@"id"]];
	
}

- (void)replyToTweet:(NSDictionary *)tweet {
	CreateTweetViewController *createTweetViewController = [[CreateTweetViewController alloc] initWithNibName:@"CreateTweetViewController" bundle:nil];
	[createTweetViewController setUserName:[_engine username]];
	[createTweetViewController setTweet:tweet];
	[createTweetViewController setTweetDelegate:self];
	[self presentModalViewController:createTweetViewController animated:YES];
	[createTweetViewController release];
}

- (void)sendTweet:(NSString *)tweetString inReplyToTweet:(NSDictionary *)tweet{
	if (tweet == nil){
		[_engine sendUpdate:tweetString];
	}
	else{
		[_engine sendUpdate:tweetString inReplyToUpdateStringID:[tweet objectForKey:@"id"]];
	}
}

#pragma mark -
#pragma mark User Interaction

-(void)createTweet{
	CreateTweetViewController *createTweetViewController = [[CreateTweetViewController alloc] initWithNibName:@"CreateTweetViewController" bundle:nil];
	[createTweetViewController setTweetDelegate:self];
	[createTweetViewController setUserName:[_engine username]];
	[self presentModalViewController:createTweetViewController animated:YES];
	[createTweetViewController release];
}

-(void)createTweetAddressedToUser:(NSString *)username {
	
}

#pragma mark -
#pragma mark ViewController Lifecycle

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewDidLoad{
	[super viewDidLoad];
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] 
									initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(createTweet)];

	self.navigationItem.rightBarButtonItem = rightButton;
	[rightButton release];
	
	[self setTimeLineTweets:[NSMutableArray array]];
	
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.feedTableView.bounds.size.height, self.view.frame.size.width, self.feedTableView.bounds.size.height)];
		view.delegate = self;
		[self.feedTableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void) viewDidAppear: (BOOL)animated {
	if (_engine) return;
	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	_engine.consumerKey = kOAuthConsumerKey;
	_engine.consumerSecret = kOAuthConsumerSecret;
	
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
	
	if (controller){
		[self presentModalViewController: controller animated: YES];
	}
	else {
		NSLog(@"%@", [_engine getFollowedTimelineSinceID:0 startingAtPage:0 count:100]);
	}
	
	[self setTitle:[_engine username]];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	[feedTableView release];
	[timeLineTweets release];
	[_engine release];
    [super dealloc];
}

@end
