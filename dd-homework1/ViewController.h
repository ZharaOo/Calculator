//
//  ViewController.h
//  dd-homework1
//
//  Created by babi4_97 on 06.10.2017.
//  Copyright © 2017 Ivan Babkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSString *intermediateValue;
    NSMutableArray *numbers;
    
    NSMutableArray *actions;
}

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)numberPressed:(id)sender;
- (IBAction)mathActionPressed:(id)sender;
- (IBAction)equalsPressed:(id)sender;
- (IBAction)resetResult:(id)sender;
- (IBAction)separationPointPressed:(id)sender;
- (IBAction)changeOfSign:(id)sender;

@end

