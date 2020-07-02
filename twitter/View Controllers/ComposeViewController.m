//
//  ComposeViewController.m
//  twitter
//
//  Created by Joey R. Hernandez Perez on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    self.textView.text = @"";
}

- (IBAction)onTweetTap:(id)sender {
    [[APIManager shared] postStatusWithText:self.textView.text
                                  completion:^(Tweet *tweet, NSError *error) {
        if (error != nil) {
            NSLog(@"There was an error posting new tweet");
        }
        else {
            NSLog(@"Posted tweet successfully");
            [self.delegate didTweet:tweet];
        }
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (IBAction)onCloseTap:(id)sender {

    [self dismissViewControllerAnimated:true completion:nil];
}

@end
