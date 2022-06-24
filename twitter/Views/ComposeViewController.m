//
//  ComposeViewController.m
//  twitter
//
//  Created by Yonatan Desta on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"


@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetInDetail;

@end

@implementation ComposeViewController
- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)didTapTweet:(id)sender {
    
    [[APIManager shared] postStatusWithText:self.tweetInDetail.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"Compose Tweet Success!");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
