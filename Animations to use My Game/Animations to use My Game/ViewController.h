//
//  ViewController.h
//  Animations to use My Game
//
//  Created by Henrique Carvalho on 2015-04-22.
//  Copyright (c) 2015 HOC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)buttonPressed:(id)sender;


@end

