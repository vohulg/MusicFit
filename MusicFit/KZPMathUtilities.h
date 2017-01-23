//
//  KZPMathUtilities.h
//  KZPUtilities
//
//  Created by Matt Rankin on 6/03/2014.
//  Copyright (c) 2014 Matt Rankin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZPMathUtilities : NSObject

+ (BOOL)numberIsFraction:(NSNumber *)number;

@end

int mod(int a, int b);
unsigned int isPowerOf2(unsigned int x);
unsigned int previousPwr2(unsigned int x);
unsigned int lowestCommonMultiple(unsigned int a, unsigned int b);
unsigned int highestCommonFactor(unsigned int a, unsigned int b);
unsigned int nextMultiple(unsigned int a, unsigned int factor);