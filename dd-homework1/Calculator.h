//
//  Calculator.h
//  dd-homework1
//
//  Created by babi4_97 on 19.10.2017.
//  Copyright © 2017 Ivan Babkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

@property (nonatomic, strong) NSString *intermediateValue;

- (NSString *)numberPressed:(NSString *)num;
- (NSString *)mathActionPressed:(NSString *)act;
- (NSString *)equalsPressed;
- (NSString *)separationPointPressed;
- (NSString *)changeSign;
- (NSString *)resetResult;
@end
