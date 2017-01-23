//
//  VGAudioPlayViewController.m
//  MusicFit
//
//  Created by Admin on 17/01/17.
//  Copyright © 2017 vohulg. All rights reserved.
//

#import "VGAudioPlayViewController.h"

@interface VGAudioPlayViewController ()

@end

@implementation VGAudioPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Song is %@ \n", self.currentSong.nameSong);
    
    //NSString* pathForPlay = [[NSBundle mainBundle] pathForResource:@"Березка.mp3" ];
    //NSString* pathForPlay = [[NSBundle mainBundle] path
   // id asset = [[NSDataAsset alloc] initWithName:@""];
    
    NSURL* url = [NSURL URLWithString:@"http://dl.asfadel.kz/Berezka.mp3"];
    NSError* error2 = nil;
    NSData* audioFile = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error2];
    if (error2){
        NSLog(@"VGError: no load mp3 file with error %@ \n", [error2 localizedDescription]);
        return;
    }
    
    NSError* error = nil;
    self.player = [[AVAudioPlayer alloc] initWithData:audioFile error:&error];
    
    if (error){
        NSLog(@"VGError: audio player not inited with error %@ \n", [error localizedDescription]);
        return;
    }
    
    self.player.delegate = self;
    
    self.progressPlaying.progress = 0.0;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) playWithTimer:(NSTimeInterval) duration andCurrentPosition:(NSTimeInterval) currentPosition andRepeats:(BOOL)repeat {
    
    self.player.currentTime = currentPosition;
    if(self.timerPlayPartFile){
        [self.timerPlayPartFile invalidate];
    }
    self.timerPlayPartFile = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(stopTimer) userInfo:nil repeats:repeat];
    
    self.progressDuration = duration;
    [self showProgress:duration];
    
    self.progressPlaying.progress = 0.0;
    [self.player play];
    NSLog(@"VGLOG:Interval started \n");

}

-(void)stopTimer {
    
    NSLog(@"VGLOG:Interval stoped \n");

    if (self.timerPlayPartFile){
        [self.timerPlayPartFile invalidate];
        self.timerPlayPartFile = nil;
    }
    
    [self.player stop];
}


-(void) showProgress:(NSTimeInterval)duration {
    
    if(!self.currentProgressPosition ){
        self.currentProgressPosition = 0.0;
        self.progressDuration = duration;
    }
    
    self.timerShowProgress = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickProgress) userInfo:nil repeats:YES];
}

-(void)tickProgress {
 
     if(self.currentProgressPosition >= self.progressDuration){
        if (self.timerShowProgress){
         [self.timerShowProgress invalidate];
         self.timerShowProgress = nil;
         self.progressPlaying.progress = self.progressDuration;
         self.currentProgressPosition = 0;
         self.progressDuration = 0;
            
        }
         
    }
    
    self.progressPlaying.progress = self.currentProgressPosition / self.progressDuration;
    
    self.currentProgressPosition++;
}


- (IBAction)actionPlay:(id)sender {
    
    BOOL isReadyToPlay = [self.player prepareToPlay];
    if (!isReadyToPlay){
        NSLog(@"player inited but not ready to play \n");
        return;
    }
    
    if (self.player){
        
        [self playWithTimer:10.0 andCurrentPosition:24.0 andRepeats:NO];
        
        // set rate
        //self.player.enableRate = YES;
        //self.player.rate = 0.8;
        
        // set offset
        //self.player.duration;
        //NSLog(@"VGLOG:duration of song %f", self.player.duration);
        //self.player.currentTime = 6.0;
        
        
       //[self.player play];
    }
    
    
    
    
}
- (IBAction)actionStop:(id)sender {
    
    if (self.player){
        [self.player stop];
        
    }
    
}

- (IBAction)actionVolumeChange:(id)sender {
    
    NSLog(@"actionVolumeChange called \n");

    if (self.player){
        self.player.volume = self.volumeSlider.value;
    }

}
- (IBAction)actionUpInside:(id)sender {
    
    NSLog(@"actionUpInside called \n");

}
- (IBAction)actionShowAnswer:(id)sender {
}
@end
