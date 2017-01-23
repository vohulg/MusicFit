//
//  VGMusicNotationView.h
//  MusicFit
//
//  Created by Admin on 21/01/17.
//  Copyright © 2017 vohulg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VGMusicNotationViewDelegate <NSObject>

- (void)notationViewHasNewContentSize:(CGSize)size;
- (void)notationViewFailedToProcess;

@end


@interface VGMusicNotationView : UIWebView <UIWebViewDelegate>

@property (weak, nonatomic) id<VGMusicNotationViewDelegate> musicNotationDelegate;
@property (nonatomic) BOOL shouldAutomaticallyResize;
@property (nonatomic) CGSize maximumSize;

- (void)renderNotationString:(NSString *)notationString;

@end
