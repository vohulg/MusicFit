//
//  KZPMusicSciNotation.m
//  KZPUtilities
//
//  Created by Matt Rankin on 12/03/2014.
//  Copyright (c) 2014 Matt Rankin. All rights reserved.
//

#import "KZPMusicSciNotation.h"
#import "NSString+functions.h"
#import "KZPMathUtilities.h"

static char noteNames[12] = {'C', '\0', 'D', '\0', 'E', 'F', '\0', 'G', '\0', 'A', '\0', 'B'};
static char accidentals[5] = {'B', 'b', 'n', '#', 'x'};
static int modifiers[5] = {-2, -1, 0, 1, 2};
static int defaultModifiers[12] = {0, 1, 0, -1, 0, 0, 1, 0, -1, 0, -1, 0};


#pragma mark - Sci-notation fundamentals -

bool isAccidental(char c)
{
    for (int i = 0; i < 5; i++) {
        if (accidentals[i] == c) return true;
    }
    return false;
}

char getAccidental(int modifier)
{
    for (int i = 0; i < 5; i++) {
        if (modifiers[i] == modifier) return accidentals[i];
    }
    return '\0';
}

char getNoteName(int pitch, int modifier, int *octave)
{
    int noteID = mod(pitch, 12) - modifier;
    int ove = pitch / 12 - 1;
    if (noteID < 0) ove--;
    if (noteID > 11) ove++;
    noteID = mod(noteID, 12);
    if (octave != NULL) *octave = ove;
    return noteNames[noteID];
}

unsigned int getModifier(char accidental)
{
    for (int i = 0; i < 5; i++) {
        if (accidentals[i] == accidental) return modifiers[i];
    }
    return 0;
}

unsigned int getNoteID(char noteName)
{
    for (int i = 0; i < 12; i++) {
        if (noteNames[i] == noteName) return i;
    }
    return 0;
}

unsigned int getPitchNumber(char noteName, char accidental, int octave)
{
    return getNoteID(noteName) + getModifier(accidental) + 12 * (octave + 1);
}


#pragma mark - Public methods -


@implementation KZPMusicSciNotation

+ (BOOL)noteIsWhite:(int)pitch
{
    return getNoteName(pitch, 0, NULL) != '\0';
}

+ (BOOL)accidental:(unsigned char)accidental isLegalForPitch:(int)pitch
{
    if (!isAccidental(accidental)) return NO;
    int modifier = getModifier(accidental);
    return noteNames[mod(pitch - modifier, 12)] != '\0';
}

+ (BOOL)modifier:(MusicSpelling)modifier isLegalForPitch:(int)pitch
{
    if (modifier < -2 || modifier > 2) return NO;
    return noteNames[mod(pitch - modifier, 12)] != '\0';
}

+ (MusicSpelling)resolveModifier:(MusicSpelling)modifier forPitch:(int)pitch
{
    if (modifier < MusicSpelling_DoubleFlat || modifier > MusicSpelling_DoubleSharp) {
        modifier = defaultModifiers[mod(pitch, 12)];
    }
    if (!getNoteName(pitch, modifier, NULL)) {
        if (modifier == 0) {
            modifier = defaultModifiers[mod(pitch, 12)];
        } else {
            modifier += (modifier < 0 ? 1 : -1);
        }
    }
    return modifier;
}

+ (NSString *)sciNotationForPitch:(int)pitch modifier:(MusicSpelling)modifier resolve:(BOOL)resolve
{
    if (resolve) {
        modifier = [self resolveModifier:modifier forPitch:pitch];
    }
    int octave;
    char noteName = getNoteName(pitch, modifier, &octave);
    if (!noteName) return nil;
    char accidental = getAccidental(modifier);
    return [NSString stringWithFormat:@"%c%c%d", noteName, accidental == 'n' ? '\0' : accidental, octave];
}

+ (NSInteger)pitchValueForSciNotation:(NSString *)sciNotation modifier:(MusicSpelling *)modifier
{
    if (![sciNotation matchedByRegex:REGEX__SCI_NOTATION]) return NAN;
    const char *sn = [sciNotation UTF8String];
    char noteName = toupper(sn[0]);
    char accidental = isAccidental(sn[1]) ? sn[1] : '\0';
    int octave = isAccidental(sn[1]) ? atoi(sn+2) : atoi(sn+1);
    if (modifier) *modifier = getModifier(accidental);
    return (NSInteger)getPitchNumber(noteName, accidental, octave);
}

@end
