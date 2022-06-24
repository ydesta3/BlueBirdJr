//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Yonatan Desta on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TimelineViewController.h"
#import "DateTools.h"


@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetDescription.text = self.tweet.text;
    self.userName.text = self.tweet.user.name;
    NSString *at = @"@";
    NSString *screenAlias = self.tweet.user.screenName;
    self.userAlias.text = [ at stringByAppendingString:screenAlias];
    self.dateOfTweet.text = self.tweet.createdAtString;
    NSString *retweetNum = [NSString stringWithFormat:@"%i", self.tweet.retweetCount] ;
    NSString *likeNum = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount] ;

    [self.retweetButton setTitle:retweetNum forState:(UIControlStateNormal)];
    [self.likeButton setTitle:likeNum forState:(UIControlStateNormal)];

    
    // fetches user profile picture
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    // stores data in image object
    UIImage *image = [UIImage imageWithData:urlData];
    // matches types, sets image to profile picture
    self.userPhoto.image = image;
    self.userPhoto.layer.cornerRadius = (self.userPhoto.frame.size.height)/2;
    self.userPhoto.clipsToBounds = true;
    
    [self refreshFavoritedData];
    [self refreshRetweetData];
}


- (IBAction)didTapFavorite:(id)sender {
    // updates local tweet model
    if(!self.tweet.favorited) {
        self.tweet.favorited = YES;
        // update cell UI
        [self refreshFavoritedData];
        // send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                 self.tweet.favorited = NO;
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 self.tweet.favoriteCount += 1;
                 NSString *likeNum = [NSString stringWithFormat:@"%i", tweet.favoriteCount] ;
                 [self.likeButton setTitle:likeNum forState:(UIControlStateNormal)];
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
        }];
    } else {
        self.tweet.favorited = NO;
        // update cell UI
        [self refreshFavoritedData];
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                 self.tweet.favorited = YES;
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 self.tweet.favoriteCount -= 1;
                 NSString *likeNum = [NSString stringWithFormat:@"%i", tweet.favoriteCount] ;
                 [self.likeButton setTitle:likeNum forState:(UIControlStateNormal)];
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
        }];
        
    }
}

- (IBAction)didTapRetweet:(id)sender {
    if(!self.tweet.retweeted){
        // updates local tweet model
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        // update cell UI
        [self refreshRetweetData];
    
        // send a POST request to the POST favorites/create endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                 self.tweet.retweeted = NO;
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 self.tweet.retweetCount += 1;
                 NSString *retweetNum = [NSString stringWithFormat:@"%i", tweet.retweetCount] ;
                 [self.retweetButton setTitle:retweetNum forState:(UIControlStateNormal)];
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
        }];
    } else {
        self.tweet.retweeted = NO;
        // update cell UI
        [self refreshRetweetData];
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                 self.tweet.retweeted = YES;
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 self.tweet.retweetCount -= 1;
                 NSString *retweetNum = [NSString stringWithFormat:@"%i", tweet.retweetCount] ;
                 [self.retweetButton setTitle:retweetNum forState:(UIControlStateNormal)];
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
        }];
        
        
    }
}


-(void) refreshFavoritedData{
    if(self.tweet.favorited) {
        UIImage *favoritedButton = [UIImage imageNamed:@"favor-icon-red.png"];
        [self.likeButton setImage:favoritedButton forState:UIControlStateNormal];
    } else {
        UIImage *favoritedButton = [UIImage imageNamed:@"favor-icon.png"];
        [self.likeButton setImage:favoritedButton forState:UIControlStateNormal];
    }
}

-(void) refreshRetweetData{
    if(self.tweet.retweeted) {
        UIImage *favoritedButton = [UIImage imageNamed:@"retweet-icon-green.png"];
        [self.retweetButton setImage:favoritedButton forState:UIControlStateNormal];
    } else {
        UIImage *favoritedButton = [UIImage imageNamed:@"retweet-icon.png"];
        [self.retweetButton setImage:favoritedButton forState:UIControlStateNormal];
    }
}

@end
