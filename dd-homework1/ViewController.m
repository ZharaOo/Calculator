//
//  ViewController.m
//  dd-homework1
//
//  Created by babi4_97 on 05.10.2017.
//  Copyright © 2017 Ivan Babkin. All rights reserved.
//

#import "ViewController.h"

#import "Constants.h"

@interface ViewController () {
     Calculator *calculator;
}

@end

@implementation ViewController
@synthesize resultLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    calculator = [[Calculator alloc] init];
    resultLabel.adjustsFontSizeToFitWidth = YES;
    resultLabel.text = ZERO;
}

- (IBAction)numberPressed:(UIButton *)sender {
    [self showResult:[calculator numberPressed:sender.titleLabel.text]];
}

- (IBAction)mathActionPressed:(UIButton *)sender {
    [self showResult:[calculator mathActionPressed:sender.titleLabel.text]];
}

- (IBAction)equalsPressed:(id)sender {
    [self showResult:[calculator equalsPressed]];
}

- (IBAction)separationPointPressed:(id)sender {
    [self showResult:[calculator separationPointPressed]];
}

- (IBAction)changeOfSign:(id)sender {
    [self showResult:[calculator changeSign]];
}

- (IBAction)resetResult:(id)sender {
    [self showResult:[calculator resetResult]];
}

- (void)showResult:(NSString *)str {
    if (![str isEqualToString:NEW_NUMBER]) {
        resultLabel.text = str;
    }
}

@end
