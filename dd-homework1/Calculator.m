//
//  Calculator.m
//  dd-homework1
//
//  Created by babi4_97 on 19.10.2017.
//  Copyright © 2017 Ivan Babkin. All rights reserved.
//

#import "Calculator.h"
#import "Constants.h"

@interface Calculator() {
@private
    NSMutableArray *numbers;
    NSMutableArray *actions;
}

@end

@implementation Calculator

- (id)init {
    self = [super init];
    if (self) {
        [self resetResult];
    }
    return self;
}

- (NSString *)numberPressed:(NSString *)num {
    if ([self.intermediateValue isEqualToString:ZERO] || [self.intermediateValue isEqualToString:NEW_NUMBER]) {
        self.intermediateValue = [NSString stringWithFormat:@"%@", num];
    } else {
        self.intermediateValue = [NSString stringWithFormat:@"%@%@", self.intermediateValue, num];
    }
    
    return self.intermediateValue;
}

- (NSString *)mathActionPressed:(NSString *)act {
    if (![self.intermediateValue isEqualToString:NEW_NUMBER]) {
        [numbers addObject:[self numberValueFromString:self.intermediateValue]];
        self.intermediateValue = NEW_NUMBER;
    }
    
    if (actions.count == numbers.count) {
        [actions removeLastObject];
    }
    
    if ([actions count] == 0) {
        [actions addObject:act];
        return self.intermediateValue;
    }
    
    if (([self isActionStrong:act]) && (![self isActionStrong:actions[0]])) {
        [actions addObject:act];
    } else {
        if ([numbers count] > 1) {
            NSNumber *result = [self performActions:actions withNumbers:numbers];
            numbers = [[NSMutableArray alloc] initWithObjects:result, nil];
            actions = [[NSMutableArray alloc] initWithObjects:act, nil];
            return [self writeResult:result];
        } else {
            [actions addObject:act];
        }
    }
    
    return self.intermediateValue;
}

- (NSString *)equalsPressed {
    if (![self.intermediateValue isEqualToString:NEW_NUMBER] && numbers.count != 0 && actions.count != 0) {
        [numbers addObject:[self numberValueFromString:self.intermediateValue]];
        if (numbers.count == actions.count) {
            [actions removeLastObject];
        }
        NSNumber *result = [self performActions:actions withNumbers:numbers];
        numbers = [[NSMutableArray alloc] initWithObjects:result, nil];
        actions = [[NSMutableArray alloc] init];
        self.intermediateValue = NEW_NUMBER;
        return [self writeResult:result];
    }
    return self.intermediateValue;
}

- (NSString *)separationPointPressed {
    if ([self.intermediateValue isEqualToString:NEW_NUMBER]) {
        self.intermediateValue = @"0,";
    } else {
        if (![self.intermediateValue containsString:@","]) {
            self.intermediateValue = [NSString stringWithFormat:@"%@,", self.intermediateValue];
        }
    }
    return self.intermediateValue;
}

- (NSString *)changeSign {
    if (![self.intermediateValue isEqualToString:NEW_NUMBER] && ![self.intermediateValue isEqualToString:ZERO]) {
        if ([self.intermediateValue characterAtIndex:0] == '-') {
            self.intermediateValue = [self.intermediateValue substringFromIndex:1];
        } else {
            self.intermediateValue = [NSString stringWithFormat:@"-%@", self.intermediateValue];
        }
    }
    return self.intermediateValue;
}

- (BOOL)isActionStrong:(NSString *)act {
    return ([act isEqualToString:MULTIPLICATION] || [act isEqualToString:DIVISION]);
}

- (NSNumber *)performActions:(NSMutableArray *)acts withNumbers:(NSMutableArray *)nums {
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

- (NSString *)resetResult {
    numbers = [[NSMutableArray alloc] init];
    actions = [[NSMutableArray alloc] init];
    self.intermediateValue = ZERO;
    
    return ZERO;
}

- (NSNumber *)numberValueFromString:(NSString *)string {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return [f numberFromString:string];
}

- (NSString *)writeResult:(NSNumber *)result {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.alwaysShowsDecimalSeparator = NO;
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.maximumFractionDigits = 8;
    numberFormatter.minimumIntegerDigits = 1;
    return [numberFormatter stringFromNumber:result];
}

@end
