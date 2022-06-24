//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "TweetDetailsViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetTableView;
@property (nonatomic, strong)NSMutableArray *arrayOfTweets;
@property (nonatomic, strong) IBOutlet UIRefreshControl *refresh;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetTableView.dataSource = self;
    self.tweetTableView.delegate = self;
    [self getTimeline];
    
    self.refresh = [[UIRefreshControl alloc] init];
    [self.refresh addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tweetTableView addSubview: self.refresh];


}
-(void)getTimeline{
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = (NSMutableArray *)tweets;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            //
            for (Tweet *tweet in tweets) {
                // uses text field in tweet model to fetch the text body of a tweet.
                NSString *text = tweet.text;
                NSLog(@": YD: %@", text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tweetTableView reloadData];
        [self.refresh endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)didTapLogout:(id)sender {
    // TimelineViewController.m
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // UINavigationController *navigationController = [segue destinationViewController];
    if ([segue.identifier  isEqual: @"toDetailsPage"]){
        TweetDetailsViewController *tweetDetailsController = [segue destinationViewController];
        NSIndexPath *index = self.tweetTableView.indexPathForSelectedRow;
        Tweet *dataToPass = self.arrayOfTweets[index.row];
        tweetDetailsController.tweet = dataToPass;
        
    } else{
        ComposeViewController *composeController = [segue destinationViewController];
        composeController.delegate = self;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    // sets tweet instance to current tweet in tweet cell
    tweetCell.tweet = tweet;
    return tweetCell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}


- (void)didTweet:(nonnull Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tweetTableView reloadData];
}


@end
