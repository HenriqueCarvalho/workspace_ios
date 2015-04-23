//
//  MenuViewController.h
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-03-29.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MenuViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic, retain) AVAudioPlayer *player;

- (IBAction)startTheGame:(id)sender;
- (IBAction)seeTheRankTouched:(id)sender;
- (IBAction)aboutUsTouched:(id)sender;

@end
