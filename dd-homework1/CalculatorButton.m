//
//  CalculatorButton.m
//  dd-homework1
//
//  Created by babi4_97 on 06.10.2017.
//  Copyright © 2017 Ivan Babkin. All rights reserved.
//

#import "CalculatorButton.h"

@implementation CalculatorButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height / 2;
}

@end
