//
//  DetailsViewController.m
//  twitter
//
//  Created by Joey R. Hernandez Perez on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAgoLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *replysButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetsButton;
@property (weak, nonatomic) IBOutlet UIButton *favoritesButton;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesCountLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.profileImageView setImageWithURL:self.tweet.user.profileImageURL];
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.createdAgoLabel.text = self.tweet.createdAgoString;
    self.tweetTextLabel.text = self.tweet.text;
    self.retweetsButton.selected = self.tweet.retweeted;
    self.favoritesButton.selected = self.tweet.favorited;
    self.retweetsCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoritesCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    
    if (self.retweetsButton.isSelected) {
        
        self.retweetsButton.selected = NO;
        self.tweet.retweetCount -= 1;
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        
        self.retweetsButton.selected = YES;
        self.tweet.retweetCount += 1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeting the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    self.tweet.retweeted = self.retweetsButton.selected;
    [self refreshData];
}

- (IBAction)didTapFavorite:(id)sender {
    
    if (self.tweet.favorited) {
        
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    self.favoritesButton.selected = self.tweet.favorited;
    [self refreshData];
}

- (void)refreshData {
    
    self.favoritesCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    [self.favoritesButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateSelected];
    
    self.retweetsCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    [self.retweetsButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
