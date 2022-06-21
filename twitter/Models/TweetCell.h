//
//  TweetCell.h
//  twitter
//
//  Created by Yonatan Desta on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userAlias;
@property (weak, nonatomic) IBOutlet UILabel *dateOfTweet;
@property (weak, nonatomic) IBOutlet UIButton *didTapReply;
@property (weak, nonatomic) IBOutlet UIButton *didTapRetweet;
@property (weak, nonatomic) IBOutlet UIButton *didTapLike;
@property (weak, nonatomic) IBOutlet UILabel *tweet;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UIButton *likeCount;
@property (weak, nonatomic) IBOutlet Tweet *Tweet;





@end

NS_ASSUME_NONNULL_END
