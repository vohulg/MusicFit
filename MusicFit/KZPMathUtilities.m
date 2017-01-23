//
//  KZPMathUtilities.h
//  KZPUtilities
//
//  Created by Matt Rankin on 6/03/2014.
//  Copyright (c) 2014 Matt Rankin. All rights reserved.
//

#import "KZPMathUtilities.h"

@implementation KZPMathUtilities

+ (BOOL)numberIsFraction:(NSNumber *)number
{
    double dValue = [number doubleValue];
    if (dValue < 0.0)
        return (dValue != ceil(dValue));
    else
        return (dValue != floor(dValue));
}

@end

unsigned int isPowerOf2(unsigned int x)
{
    return ((x != 0) && !(x & (x - 1)));
}

unsigned int hibit(unsigned int n) {
    n |= (n >>  1);
    n |= (n >>  2);
    n |= (n >>  4);
    n |= (n >>  8);
    n |= (n >> 16);
    return n - (n >> 1);
}

unsigned int previousPwr2(unsigned int x)
{
    unsigned int pwr = 0;
    while (x) {
        x >>= 1;
        pwr++;
    }
    return 1 << (pwr-1);
}

unsigned int lowestCommonMultiple(unsigned int a, unsigned int b)
{
    unsigned int hcf = highestCommonFactor(a, b);
    if (hcf == 0) return 0;
    return (a*b)/hcf;
}

unsigned int highestCommonFactor(unsigned int a, unsigned int b)
{
    if (a == 0 || b == 0) return 0;
    unsigned int m = MIN(a, b);
    while (a % m != 0 || b % m != 0) m--;
    return m;
}

int mod(int a, int b)
{
    int r = a % b;
    return r < 0 ? r + b : r;
}

unsigned int nextMultiple(unsigned int a, unsigned int factor)
{
    return ((a / factor) + 1) * factor;
}