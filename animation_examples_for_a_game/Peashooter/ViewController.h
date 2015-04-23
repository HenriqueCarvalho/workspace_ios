//
//  ViewController.h
//  Peashooter
//
//  Created by Gabriel  on 28/3/13.
//  Copyright (c) 2013 App Ninja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)buttonPressed:(id)sender;

@end
