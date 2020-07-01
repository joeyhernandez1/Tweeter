//
//  TweetCell.m
//  twitter
//
//  Created by Joey R. Hernandez Perez on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

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
    
    if (self.favoritesButton.isSelected) {
        
        self.favoritesButton.selected = NO;
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
        
        self.favoritesButton.selected = YES;
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
    
    self.tweet.favorited = self.favoritesButton.selected;
    [self refreshData];
}

- (void)refreshData {
    
    self.favoritesCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    [self.favoritesButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateSelected];
    
    self.retweetsCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    [self.retweetsButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
}


@end
