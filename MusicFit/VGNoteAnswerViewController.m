//
//  KZPViewController.m
//  KZPMusicNotation
//
//  Created by Matt Rankin on 21/09/2014.
//  Copyright (c) 2014 Sudoseng. All rights reserved.
//

#import "VGNoteAnswerViewController.h"
#import "VGMusicNotationView.h"


@interface VGNoteAnswerViewController () <VGMusicNotationViewDelegate>

@property (weak, nonatomic) IBOutlet VGMusicNotationView *canvas;

@property (weak, nonatomic) NSString* answerInNote;

@end

@implementation VGNoteAnswerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canvas.musicNotationDelegate = self;
    self.canvas.shouldAutomaticallyResize = NO;
    
  // [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(showAnswer) userInfo:nil repeats:NO];

    
    
    
    //[self.canvas renderNotationString:@"Q=treble T=4/4 K=F C4/4 Cx4/8 Eb4/8 ' F4/8 AB4/8 ' Ab4/4 | Eb4/8 D4/8^ ' D4/8 C4/8 ' Ab3/8 Eb3+G3+C4/4. \\\\ Q=bass T=4/4 K=F Eb3+G3/2 C3/2 | F#2/2^ F#2/8 C2/4."];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    NSLog(@"Start show note \n");
    [self showAnswer];
    NSLog(@"End show note \n");
    

}

-(void) showAnswer {
    
    /*
    self.answerInNote = @"Q=treble T=4/4 K=F C4/4 Cx4/8 Eb4/8 ' F4/8 AB4/8 ' Ab4/4 | Eb4/8 D4/8^ ' D4/8 C4/8 ' Ab3/8 Eb3+G3+C4/4. \\\\ Q=bass T=4/4 K=F Eb3+G3/2 C3/2 | F#2/2^ F#2/8 C2/4.";
    [self.canvas renderNotationString:self.answerInNote];
     
     */
    NSLog(@"webview loaded \n");
    //test
    /*
    NSString* noteString = @"options space=20 tab-stems=true stave-distance=0 tab-stem-direction=down \n \
    tabstave notation=true key=Am time=4/4 \n\
    notes :8 0/1 0/1 0/1 0/1 | :q 3/2 :8 1/2 1/2 |  0/2 2/3 | :8 0/1 0/1 3/1 0/1 \n \
    options space=20 \n\
    tabstave notation=true \n\
    notes :8 3/2 3/2 1/2 1/2 | :q 0/1 2/3 | :qd 0/2 :8 1/2 | :q 3/1 :8 1/2 1/2 \n\
    options space=20 \n\
    tabstave notation=true \n\
    notes :q 0/2 2/3 | :qd 0/2 :8 1/2 | :8 3/2 3/2 1/2 1/2 | :q 0/2 2/3 ";
     */
    
    NSString* noteString = @"options space=20 tab-stems=true stave-distance=0 tab-stem-direction=down \
                            tabstave notation=true key=Am time=4/4";
    

    
    
    [self.canvas renderNotationString:noteString];
    
    
}



#pragma mark - KZPMusicNotationDelegate -

- (void)notationViewFailedToProcess
{
    NSLog(@"Failed to process string: %@", self.answerInNote);
}

- (void)notationViewHasNewContentSize:(CGSize)size
{
    // Do something with the new content size
}

@end
