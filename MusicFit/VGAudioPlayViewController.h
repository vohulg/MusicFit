//
//  VGAudioPlayViewController.h
//  MusicFit
//
//  Created by Admin on 17/01/17.
//  Copyright © 2017 vohulg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VGSong+CoreDataClass.h"
#import "AVFoundation/AVAudioPlayer.h"
#import "AVFoundation/AVAudioSettings.h"


@interface VGAudioPlayViewController : UIViewController <AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *playBtn;

- (IBAction)actionPlay:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *stopBtn;

@property (strong, nonatomic) VGSong* currentSong;

@property (strong, nonatomic) AVAudioPlayer* player;

@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

- (IBAction)actionStop:(id)sender;

- (IBAction)actionVolumeChange:(id)sender;

@property (strong, nonatomic) NSTimer* timerPlayPartFile;
@property (strong, nonatomic) NSTimer* timerShowProgress;
@property (assign, nonatomic) NSTimeInterval currentProgressPosition;
@property (assign, nonatomic) NSTimeInterval progressDuration;

@property (weak, nonatomic) IBOutlet UIProgressView *progressPlaying;


- (IBAction)actionShowAnswer:(id)sender;




@end
