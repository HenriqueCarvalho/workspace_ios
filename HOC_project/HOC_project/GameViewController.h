//
//  ViewController.h
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-03-21.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Player.h"
#import "MenuViewController.h"

@interface GameViewController : UIViewController <UIAlertViewDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic) int score;
@property (nonatomic) int seconds;
@property (nonatomic) int random;
@property (nonatomic) int imageHeight;
@property (nonatomic) int imageWidth;
@property (nonatomic) int numbersOfimages;

@property (nonatomic) double speed;
@property (nonatomic) double red;
@property (nonatomic) double green;
@property (nonatomic) double blue;

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;
@property (weak, nonatomic) IBOutlet UIImageView *block1;
@property (weak, nonatomic) IBOutlet UIImageView *block2;
@property (weak, nonatomic) IBOutlet UIImageView *block3;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *soundImg;

@property (nonatomic, retain) AVAudioPlayer *player;
@property (strong, nonatomic) Player * playerObject;
@property (nonatomic) BOOL isPlaying;

@property (strong, nonatomic) NSMutableArray *imgs;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *backgroundColorTime;
@property (strong, nonatomic) NSMutableArray * playersArray;

- (IBAction)playOrPauseSound:(id)sender;
- (IBAction)getBackToMenu:(id)sender;
- (void)saveTheRecord:(Player *) newPlayer;
- (id)firstObjectOfArray:(NSMutableArray*) mutableArray;

@end

