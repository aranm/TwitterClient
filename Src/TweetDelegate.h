//
//  TweetDelegate.h
//  TwitterClient
//
//  Created by Aran Mulholland on 27/02/11.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TweetDelegate
- (void)favouriteTweet:(NSDictionary *)tweet;
- (void)retweet:(NSDictionary *)tweet;
- (void)replyToTweet:(NSDictionary *)tweet;
- (void)sendTweet:(NSString *)tweetString inReplyToTweet:(NSDictionary *)tweet;
@end
