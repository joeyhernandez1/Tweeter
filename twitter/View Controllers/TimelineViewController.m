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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



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
    
    NSURL *profileImageURL = [NSURL URLWithString:cell.tweet.user.profileImageURLString];
    [cell.profileImageView setImageWithURL:profileImageURL];
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tweetsArray.count;
}

@end
