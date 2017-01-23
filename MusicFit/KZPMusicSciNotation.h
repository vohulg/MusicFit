//
//  KZPMusicSciNotation.h
//  KZPUtilities
//
//  Created by Matt Rankin on 12/03/2014.
//  Copyright (c) 2014 Matt Rankin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REGEX__SCI_NOTATION     @"([A-G]|[a-g])(B|b|n|#|x)?(-?[0-9]+)"

typedef enum {
    MusicSpelling_Default = -3,
    MusicSpelling_DoubleFlat = -2,
    MusicSpelling_Flat,
    MusicSpelling_Natural,
    MusicSpelling_Sharp,
    MusicSpelling_DoubleSharp
} MusicSpelling;

@interface KZPMusicSciNotation : NSObject

+ (BOOL)noteIsWhite:(int)pitch;
+ (BOOL)accidental:(unsigned char)accidental isLegalForPitch:(int)pitch;
+ (BOOL)modifier:(MusicSpelling)modifier isLegalForPitch:(int)pitch;
+ (MusicSpelling)resolveModifier:(MusicSpelling)modifier forPitch:(int)pitch;
+ (NSString *)sciNotationForPitch:(int)pitch modifier:(MusicSpelling)modifier resolve:(BOOL)resolve;
+ (NSInteger)pitchValueForSciNotation:(NSString *)sciNotation modifier:(MusicSpelling *)modifier;

@end
