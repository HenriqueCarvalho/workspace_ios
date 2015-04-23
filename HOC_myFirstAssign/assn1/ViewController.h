//
// Assignment 1 and Assignment 2
//
// description:
// 1 _ Create a protocol, calculatorprotocol,has a single required
// method:
//     => showresult: (NSString *) result.
// 2 _ Create a calculator class with a single method, calculate,
// which takes 3 arguments, number1, operator, and number2. After
// the calculation, it will call the protocol method to display the
// calculation result by the delegate.
// 3 _ Make the view controller to adopt the calculatorprotocol.
// 4 _ Design the user interface
//
//  ViewController.h
//  assn1
//
//  Created by Henrique Carvalho on 2015-01-20.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"
#import "calculatorprotocol.h"

@interface ViewController : UIViewController <calculatorprotocol>
@property (weak, nonatomic) IBOutlet UITextField * inputNumber1;
@property (weak, nonatomic) IBOutlet UITextField * inputOperator;
@property (weak, nonatomic) IBOutlet UITextField * inputNumber2;
@property (weak, nonatomic) IBOutlet UILabel * outputResult;
- (IBAction) test:(UIButton *)sender;


@end

