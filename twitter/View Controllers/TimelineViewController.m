//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"

@interface TimelineViewController () <UITableViewDataSource,
                                      UITableViewDelegate,
                                      ComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweetsArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self getTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                         action:@selector(getTweets)
                         forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}

-(void)getTweets {
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
           
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweetsArray = (NSMutableArray *) tweets;
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController *)navigationController.topViewController;
    composeController.delegate = self;
}

- (void) didTweet:(Tweet *)tweet {
    [self.tweetsArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweetsArray[indexPath.row];
    cell.nameLabel.text = cell.tweet.user.name;
    cell.screenNameLabel.text = [@"@" stringByAppendingString:cell.tweet.user.screenName];
    cell.tweetTextLabel.text = cell.tweet.text;
    cell.retweetsCountLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.retweetCount];
    cell.favoritesCountLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.favoriteCount];
    cell.createdAtLabel.text = cell.tweet.createdAtString;
    [cell.profileImageView setImageWithURL:cell.tweet.user.profileImageURL];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tweetsArray.count;
}

@end
