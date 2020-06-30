//
//  TweetCell.h
//  twitter
//
//  Created by Joey R. Hernandez Perez on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (strong, nonatomic) IBOutlet UIButton *replysButton;
@property (strong, nonatomic) IBOutlet UIButton *retweetsButton;
@property (strong, nonatomic) IBOutlet UIButton *favoritesButton;
@property (strong, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *retweetsCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *favoritesCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *dmButton;
@property (strong, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
