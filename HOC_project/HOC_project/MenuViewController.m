//
//  MenuViewController.m
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-03-29.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupMenu {
    [self setupTheBackgroundSong];
}

-(void)setupTheBackgroundSong{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"menuSong" ofType:@"mp3"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    //these three lines below allow sound on iOS 7 and iOS 8
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    
    NSError *error = nil;
    
    self.player = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
    self.player.numberOfLoops = -1;
    [self.player prepareToPlay];
    [self.player play];
    [self.player setDelegate:self];
}



- (IBAction)startTheGame:(id)sender {
    [self.player stop];
}

- (IBAction)aboutUsTouched:(id)sender {
    [self.player stop];
}

- (IBAction)seeTheRankTouched:(id)sender {
    [self.player stop];
}

@end
