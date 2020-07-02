//
//  ComposeViewController.m
//  twitter
//
//  Created by Joey R. Hernandez Perez on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.textView.text = @"";
}

- (void) textViewDidChange:(UITextView *)textView {
    NSInteger len = textView.text.length;
    BOOL ableToTweet = self.navigationItem.rightBarButtonItem.isEnabled;
    
    if (len > 280) {
        self.characterCountLabel.textColor = [UIColor redColor];
        if (ableToTweet) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
    else {
        self.characterCountLabel.textColor = [UIColor blackColor];
        if (!ableToTweet) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }
    self.characterCountLabel.text = [NSString stringWithFormat:@"%li",280-len];
   
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
