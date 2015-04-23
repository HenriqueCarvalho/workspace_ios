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
//  ViewController.m
//  assn1
//
//  Created by Henrique Carvalho on 2015-01-20.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad
{
  [super viewDidLoad];

  // Assignment 1
  Calculator * calc = [[Calculator alloc] init];

  calc.delegate = self;

  double number1 = 10;
  double number2 = 5;
  double result = 0.0;
  NSArray * operator = @[@"+", @"-", @"*", @"/"];
  NSString * str = [[NSString alloc] init];

  for (id op in operator)
  {
    str = [str stringByAppendingFormat:@"%.02f %@ %.02f =", number1, op, number1];

    result = [calc calculate:number1 andOperator:op andNumber:number2];
    str = [str stringByAppendingFormat:@" %.02f", result];

    [self showresult:str];
    str = @"";
  }

  // Assignment 2
  self.outputResult.text = @"0.0";
}

- (void) didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void) showresult:(NSString *)result
{

  self.outputResult.text = result;
  NSLog(@"The outcome of the calculation is: %@", result);
}

- (IBAction) test:(UIButton *)sender
{
  Calculator * calc = [[Calculator alloc] init];

  int number1 = [self.inputNumber1.text intValue];
  int number2 = [self.inputNumber2.text intValue];
  NSString * operator = self.inputOperator.text;

  double result = 0.0;

  result = [ calc calculate:number1 andOperator:operator andNumber:number2];

  NSString * strResult = @"";
  strResult = [strResult stringByAppendingFormat:@" %.02f", result];

  [self showresult:strResult];

}
@end