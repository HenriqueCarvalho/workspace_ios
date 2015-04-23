//
//  ViewController.m
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-03-21.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController{
    int clickOneTime[5];
}

NSString * playersArrayKey = @"AplayersArrayKey";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPlayersArray];
    [self setupGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupGame {
    
    //Images sizes
    self.imageHeight = 100;
    self.imageWidth = 100;
    
    //Setup the time and speed
    self.seconds = 20;
    self.speed = 2.0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.speed target:self selector:@selector(elapsedTime) userInfo:nil repeats:YES];
    self.timeLabel.text = [NSString stringWithFormat:@"%i", self.seconds];
    
    //Setup the score
    self.score = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
    
    //Setup the array of images
    self.imgs = [[NSMutableArray alloc] init];
    [self.imgs addObject:_img1];
    [self.imgs addObject:_img2];
    [self.imgs addObject:_img3];
    [self.imgs addObject:_img4];
    [self.imgs addObject:_img5];
    
    //Setting numbers of images
    self.numbersOfimages = [self.imgs count];
    
    //Setup array to check if the image was clicked one time
    for(int i = 0; i < self.numbersOfimages; i++)
    {
        clickOneTime[i] = 0;
    }
    
    //Setup background
    [self setupTheBackgroundSong];
    //red = 0.028f;
    //green = 0.56f;
    //blue = 0.12f;
    //[self setupTheBackgroundColor];
    
    NSLog(@"The game was set up!");
}

-(void)AlertNewRecord{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Congratulations, You have a New record!" message:@"Please, put your name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 1;
    [alert show];
    NSLog(@"game over!");
}

-(void)AlertGameOver{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:@"You didn't break the record try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = 2;
    [alert show];
    NSLog(@"game over!");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //tag 1 tells if this alert view is about a new record
    if(alertView.tag == 1)
    {
        NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
    
        Player * newPlayer = [[Player alloc] init];
        newPlayer.name = [[alertView textFieldAtIndex:0] text];
        newPlayer.nickname = @"nickname";
        newPlayer.record = self.score;
    
        //save the game
        [self saveTheRecord: newPlayer];
    }
    
    //restart the game
    [self setupGame];
}

- (id)firstObjectOfArray:(NSMutableArray*) mutableArray {
    return mutableArray.count>0 ? mutableArray[0] : nil;
}

- (void)saveTheRecord:(Player *) newPlayer
{
    // If the player object doesn't exist, you need to create it
    if (!self.playerObject)
    {
        self.playerObject = [[Player alloc] init];
    }
    
    self.playerObject.name = newPlayer.name;
    self.playerObject.nickname = newPlayer.nickname;
    self.playerObject.record = newPlayer.record;
    
    [self addNewPlayer:self.playerObject];
}

- (void)addNewPlayer:(Player *)playerObject
{
    [self.playersArray addObject: playerObject];
    [self savePlayersArray];
    
    //reload the array to sort again
    [self loadPlayersArray];
}

- (void)savePlayersArray
{
    NSData * playersArrayData = [NSKeyedArchiver archivedDataWithRootObject:self.playersArray];
    [[NSUserDefaults standardUserDefaults] setObject:playersArrayData forKey:playersArrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) loadPlayersArray
{
    NSData * playersArrayData = [[NSUserDefaults standardUserDefaults] objectForKey:playersArrayKey];
    
    if (playersArrayData)
    {
        self.playersArray = [NSKeyedUnarchiver unarchiveObjectWithData:playersArrayData];
        [self.playersArray sortUsingSelector:@selector(compareRecords:)];
    }
    else
    {
        self.playersArray = [NSMutableArray array];
    }
}

-(void)finishTheGame{
    // Kill the timer
    [self.timer invalidate];
    [self.backgroundColorTime invalidate];
    
    //stop the song
    [self.player stop];
    
    Player * oldPlayer = [[Player alloc] init];
    oldPlayer = [self firstObjectOfArray:self.playersArray];
    int atualRecord = oldPlayer.record;
    
    //if you broke the old record or it is the first record to save
    if(atualRecord < self.score || oldPlayer == nil){
        [self AlertNewRecord];
    }
    else{
        [self AlertGameOver];
    }
}

//Set up the background color a future feature
- (void)spectrumOfColors
{
    self.view.backgroundColor = [UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:1.0f];
    
    self.red += 0.01f;
    self.green += 0.02f;
    self.blue += 0.04f;
    
    if(self.red >= 1)
        self.red = 0.01f;
    if(self.green >= 1)
        self.green = 0.02f;
    if(self.blue >= 1)
        self.blue = 0.04f;
    
    NSLog(@"red:%f green:%f blue:%f", self.red, self.green, self.blue);
}

-(void)setupTheBackgroundColor{
    self.backgroundColorTime = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(spectrumOfColors) userInfo:nil repeats:YES];
}

-(void)setupTheBackgroundSong{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"mySong" ofType:@"mp3"];
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
    self.isPlaying = YES;
}

-(void)elapsedTime {
    
    self.seconds--;
    self.timeLabel.text = [NSString stringWithFormat:@"%i", self.seconds];
    
    // To Do: What if time runs out?
    if (self.seconds <= 0) {
        [self finishTheGame];
    }
    else
    {
        self.speed = [self accelerateTheGame:self.seconds];
        [self changeTheSpeed:self.speed];
        
        UIImageView *img ;
        
        for(int pos=0; pos<self.numbersOfimages; pos++){
            if([self imageWillBeAnimated]){
                clickOneTime[pos] = 1;
                img = [self.imgs objectAtIndex:pos];
                [self animate:img];
            }
        }
    }
}

-(double) accelerateTheGame:(int)sec{
    //this way is more comfortable to play my game
    if(sec < 6)
        return 1.2;
    else if(sec < 10)
        return 1.4;
    else if(sec < 14)
        return 1.6;
    else if(sec < 16)
        return 1.8;
    
    return 2.0;
    
    //auto speed
    //return sec * 0.1;
}

-(void)changeTheSpeed:(double)time{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(elapsedTime) userInfo:nil repeats:YES];
}

//Decide if the image will be animated
-(int) imageWillBeAnimated{
    if(arc4random_uniform(2) == 0){
        return NO;
    }
    return YES;
}

//animate a img
- (void)animate: (UIImageView *)img{
    int x = img.frame.origin.x;
    int y = img.frame.origin.y;
    
    [ img setImage:[UIImage imageNamed:@"mole_1"] ];
    [ img setFrame:CGRectMake(x, y, self.imageHeight, self.imageWidth) ];
    [self.view setUserInteractionEnabled:YES];
    
    // Use the in-built animation methods by Apple to animate our img
    [UIView animateWithDuration:self.speed/2
                     animations:^{
                         [img setFrame:CGRectMake(x, y-self.imageHeight, self.imageHeight, self.imageWidth)];
                     }
     ];
    
    //Reset position of animation
    [UIView animateWithDuration:self.speed/2
                          delay:self.speed/2
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         [img setFrame:CGRectMake(x, y, self.imageHeight, self.imageWidth)];
                     }
                     completion:^(BOOL done) {
                     }
     ];
}

-(void)scored: (int) p{
    self.score = self.score + p;
}

// If you really want to interact with a moving object - you need to
// 1 - detect the touch in a UIViewController
// 2 - run a hitest against the presentationLayer of the animating UIView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    //Check if the first block was clicked
    if ([[self.block1.layer presentationLayer] hitTest:touchPoint]) {
        NSLog(@"BLOCK 1 was touched!");
    }
    else if ([[self.img1.layer presentationLayer] hitTest:touchPoint] && clickOneTime[0] == 1){
        [self.img1 setImage:[UIImage imageNamed:@"mole_2"]];
        clickOneTime[0] = 0;
        [self scored:100];
        NSLog(@"image 1 was touched!");
    }
    else if ([[self.img2.layer presentationLayer] hitTest:touchPoint] && clickOneTime[1] == 1){
        [self.img2 setImage:[UIImage imageNamed:@"mole_2"]];
        clickOneTime[1] = 0;
        [self scored:100];
        NSLog(@"image 2 was touched!");
    }
    
    //Check if the second block was clicked
    if ([[self.block2.layer presentationLayer] hitTest:touchPoint]) {
        NSLog(@"BLOCK 2 was touched!");
    }
    else if ([[self.img3.layer presentationLayer] hitTest:touchPoint] && clickOneTime[2] == 1){
        [self.img3 setImage:[UIImage imageNamed:@"mole_2"]];
        clickOneTime[2] = 0;
        [self scored:100];
        NSLog(@"image 3 was touched!");
    }
    
    //Check if the third block was clicked
    if ([[self.block3.layer presentationLayer] hitTest:touchPoint]) {
        NSLog(@"BLOCK 3 was touched!");
    }
    else if ([[self.img4.layer presentationLayer] hitTest:touchPoint] && clickOneTime[3] == 1){
        [self.img4 setImage:[UIImage imageNamed:@"mole_2"]];
        clickOneTime[3] = 0;
        [self scored:100];
        NSLog(@"image 4 was touched!");
    }
    else if ([[self.img5.layer presentationLayer] hitTest:touchPoint] && clickOneTime[4] == 1){
        [self.img5 setImage:[UIImage imageNamed:@"mole_2"]];
        clickOneTime[4] = 0;
        [self scored:100];
        NSLog(@"image 5 was touched!");
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
}

- (IBAction)playOrPauseSound:(id)sender {
    if (self.isPlaying)
    {
        // Music is currently playing
        NSLog(@"Pausing Music!");
        [self.player pause];
        self.isPlaying = NO;
        [self.soundImg setImage:[UIImage imageNamed:@"soundoff"]];
    }
    else
    {
        // Music is currenty paused/stopped
        NSLog(@"Playing music!");
        [self.player play];
        self.isPlaying = YES;
         [self.soundImg setImage:[UIImage imageNamed:@"soundon"]];
    }
}

- (IBAction)getBackToMenu:(id)sender {
    //stop the music
    [self.player stop];
    self.isPlaying = NO;
    
    //kill the game
    [self.timer invalidate];
    
    [self performSegueWithIdentifier:@"menuViewSegue" sender:sender];
    NSLog(@"Stoping Music and kill the timer!");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"menuViewSegue"])
    {
        //MenuViewController *vc = [segue destinationViewController];
        //[vc setMyObjectHere:object];
    }
}

@end
