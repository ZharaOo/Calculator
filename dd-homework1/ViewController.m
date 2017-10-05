//
//  ViewController.m
//  dd-homework1
//
//  Created by babi4_97 on 05.10.2017.
//  Copyright © 2017 Ivan Babkin. All rights reserved.
//

#import "ViewController.h"

#define NEW_NUMBER @"newNumber"

#define STRONG 1
#define WEAK 0

#define SUM @"+"
#define DIFFERENCE @"-"
#define MULTIPLICATION @"*"
#define DIVISION @"/"

@interface ViewController ()

@end

@implementation ViewController
@synthesize resultLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetResult];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)numberPressed:(id)sender {
    UIButton *number = (UIButton *)sender;
    if ([intermediateValue isEqualToString:@"0"] || [intermediateValue isEqualToString:NEW_NUMBER]) {
        intermediateValue = [NSString stringWithFormat:@"%@", [number accessibilityIdentifier]];
    } else {
        intermediateValue = [NSString stringWithFormat:@"%@%@", intermediateValue, [number accessibilityIdentifier]];
    }
    
    resultLabel.text = intermediateValue;
}

- (IBAction)mathActionPressed:(id)sender {
    UIButton *action = (UIButton *)sender;
    NSString *actionId = [action accessibilityIdentifier];
    
    if (![intermediateValue isEqualToString:NEW_NUMBER]) {
        [numbers addObject:[self numberValueFromString:intermediateValue]];
        NSLog(@"%f", [[self numberValueFromString:intermediateValue] doubleValue]);
        intermediateValue = NEW_NUMBER;
    }
    
    if ([actions count] == 0) {
        [actions addObject:actionId];
        return;
    }
    
    bool multiplicationCondition = ([self isActionStrong:actionId]) && (![self isActionStrong:actions[0]]);
    
    if (multiplicationCondition) {
        [actions addObject:actionId];
    } else {
        if ([numbers count] > 1) {
            NSNumber *result = [self performActions:actions withNumbers:numbers];
            [self showResult:result];
            numbers = [[NSMutableArray alloc] initWithObjects:result, nil];
            actions = [[NSMutableArray alloc] initWithObjects:actionId, nil];
        } else {
            [actions addObject:actionId];
        }
    }
}

-(BOOL)isActionStrong:(NSString *)act {
    return ([act isEqualToString:MULTIPLICATION] || [act isEqualToString:DIVISION]);
}

- (NSNumber *)performActions:(NSMutableArray *)acts withNumbers:(NSMutableArray *)nums{
    if (!([acts count] == 1)) {
        for (int i = 1; i < (int)[acts count]; i++) {
            nums[1] = [self performAction:acts[i] withNumbers:nums[1] and:nums[2]];
            [nums removeObjectAtIndex:2];
        }
    }
    return [self performAction:acts[0] withNumbers:nums[0] and:nums[1]];
}

-(NSNumber *)performAction:(NSString *)act withNumbers:(NSNumber *)num1 and:(NSNumber *)num2 {
    if ([act isEqualToString:SUM])
        return [NSNumber numberWithDouble:[num1 doubleValue] + [num2 doubleValue]];
    if ([act isEqualToString:DIFFERENCE])
        return [NSNumber numberWithDouble:[num1 doubleValue] - [num2 doubleValue]];
    if ([act isEqualToString:MULTIPLICATION])
        return [NSNumber numberWithDouble:[num1 doubleValue] * [num2 doubleValue]];
    if ([act isEqualToString:DIVISION])
        return [NSNumber numberWithDouble:[num1 doubleValue] / [num2 doubleValue]];
    
    return nil;
}

- (IBAction)equalsPressed:(id)sender {
    if (![intermediateValue isEqualToString:NEW_NUMBER]) {
        [numbers addObject:[self numberValueFromString:intermediateValue]];
        NSLog(@"%f", [[self numberValueFromString:intermediateValue] doubleValue]);
        intermediateValue = NEW_NUMBER;
        
        NSNumber *result = [self performActions:actions withNumbers:numbers];
        [self showResult:result];
        numbers = [[NSMutableArray alloc] initWithObjects:result, nil];
        actions = [NSMutableArray new];
    }
}

- (IBAction)separationPointPressed:(id)sender {
    if ([intermediateValue isEqualToString:NEW_NUMBER]) {
        intermediateValue = @"0,";
    } else {
        if (![intermediateValue containsString:@","]) {
            intermediateValue = [NSString stringWithFormat:@"%@,", intermediateValue];
        }
    }
    resultLabel.text = intermediateValue;
}

- (IBAction)changeOfSign:(id)sender {
    if (![intermediateValue isEqualToString:NEW_NUMBER] && ![intermediateValue isEqualToString:@"0"]) {
        if ([intermediateValue characterAtIndex:0] == '-') {
            intermediateValue = [intermediateValue substringFromIndex:1];
        } else {
            intermediateValue = [NSString stringWithFormat:@"-%@", intermediateValue];
        }
        resultLabel.text = intermediateValue;
    }
}

- (void)resetResult {
    numbers = [NSMutableArray new];
    actions = [NSMutableArray new];
    
    resultLabel.text = @"0";
    intermediateValue = @"0";
}

- (IBAction)resetResult:(id)sender {
    [self resetResult];
}

- (NSNumber *)numberValueFromString:(NSString *)string {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return [f numberFromString:string];
}

- (void)showResult:(NSNumber *)result {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.alwaysShowsDecimalSeparator = NO;
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.maximumFractionDigits = 5;
    numberFormatter.minimumIntegerDigits = 1;
    NSLog(@"result %@", result);
    resultLabel.text = [NSString stringWithFormat:@"%@", [numberFormatter stringFromNumber:result]];
 }

@end
