//
//  CalculatorButton.m
//  dd-homework1
//
//  Created by babi4_97 on 05.10.2017.
//  Copyright © 2017 Ivan Babkin. All rights reserved.
//

#import "CalculatorButton.h"

@implementation CalculatorButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height / 2;
}

@end
