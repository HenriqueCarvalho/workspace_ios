//
//  ViewController.m
//  Peashooter
//
//  Created by Gabriel  on 28/3/13.
//  Copyright (c) 2013 App Ninja. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    int score;
    int seconds;
    NSTimer *timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.timeLabel.text = @"N/A";
    self.scoreLabel.text = @"N/A";
    
    [self setupGame];
}

-(void)setupGame {
    
    // Step 1 - Initialize our variables starting values
    seconds = 10;
    score = 0;
    
    // Step 2 - Set the labels initial values
    _timeLabel.text = [NSString stringWithFormat:@"%i", seconds];
    _scoreLabel.text = [NSString stringWithFormat:@"%i", score];
    
    // Step 3 - Setup the timer too
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(elapsedTime) userInfo:nil repeats:YES];
}

-(void)elapsedTime {
    
    seconds--;
    _timeLabel.text = [NSString stringWithFormat:@"%i", seconds];
    
    // To Do: What if time runs out?
    if (seconds <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:[NSString stringWithFormat:@"Your final score is %i", score] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        // Kill the timer
        [timer invalidate];
    }
}

-(void)scored{
    score++;
    _scoreLabel.text = [NSString stringWithFormat:@"%i", score];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender {
    
    //Random int between 10 and 280
    int r = arc4random_uniform(270) + 10;
    NSLog(@"random number:%d",r);
    int x = r ;
    //center
    //int x = 150;
    int y = 300;
    
    // Step 1 - Create a new ball image
    UIImage *peaImage = [UIImage imageNamed:@"pea"];
    UIImageView *pea = [[UIImageView alloc] initWithImage:peaImage];
    [pea setFrame:CGRectMake(x, y, 35, 35)];
    
    [self.view addSubview:pea];
    
    //set user interaction
    pea.userInteractionEnabled = YES;
    pea.tag = x;
    UITapGestureRecognizer* Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapDetected:)];
    [Tap setNumberOfTapsRequired:1];
    [pea addGestureRecognizer:Tap];
    
    // Step 2 - Use the in-built animation methods by Apple to animate our pea
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseIn animations:^{
        
        [pea setFrame:CGRectMake(x, y-200, 35, 35)];
        
    } completion:^(BOOL finished) {
       [self scored];
    }];
    
   //RESET POSITION
   [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationCurveEaseIn animations:^{
    
        [pea setFrame:CGRectMake(x, y, 35, 35)];
       
    } completion:^(BOOL finished) {
        
        [pea setImage:[UIImage imageNamed:@"pea_splat"]];
        //[pea removeFromSuperview];
        
    }];
    
}

-(void)imageViewTapDetected :(id) sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSLog(@"Tag = %ld", (long)gesture.view.tag);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self setupGame];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Detect touch anywhere */
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    NSLog(@"%f", touchPoint.x);  // The x coordinate of the touch
    NSLog(@"%f", touchPoint.y);  // The y coordinate of the touch
}

@end
