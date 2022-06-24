//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Yonatan Desta on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"


NS_ASSUME_NONNULL_BEGIN

@interface TweetDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userAlias;
@property (weak, nonatomic) IBOutlet UILabel *tweetDescription;
@property (weak, nonatomic) IBOutlet UILabel *dateOfTweet;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) Tweet *tweet;


@end

NS_ASSUME_NONNULL_END
