//
//  NSString+functions.m
//  KZPUtilities
//
//  Created by Matt Rankin on 1/03/2014.
//  Copyright (c) 2014 Matt Rankin. All rights reserved.
//

#import "NSString+functions.h"

@implementation NSString (functions)

- (int)contains:(NSString *)substring
{
    if (!substring || [substring length] == 0) return 0;
    return ((int)[self length] - (int)[[self stringByReplacingOccurrencesOfString:substring withString:@""] length]) / [substring length];
}

- (BOOL)startsWith:(NSString *)substring
{
    return [[self substringToIndex:[substring length]] isEqualToString:substring];
}

- (NSString *)stringBetweenOpeningToken:(NSString *)tkOpen closingToken:(NSString *)tkClose
{
    NSString *result;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanUpToString:tkOpen intoString:NULL];
    if ([scanner isAtEnd]) return nil;
    scanner.scanLocation++;
    if ([scanner isAtEnd]) return nil;
    [scanner scanUpToString:tkClose intoString:&result];
    return result;
}

- (NSString *)stringByRemovingOccurrencesOfString:(NSString *)string
{
    return [self stringByReplacingOccurrencesOfString:string withString:@""];
}

- (BOOL)matchedByRegex:(NSString *)pattern
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
}

- (NSString *)trimWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (NSString *)randomStringOfLength:(NSUInteger)length
{
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSUInteger alphabetLength = [alphabet length];
    NSMutableString *s = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % alphabetLength;
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

+ (NSString *)token
{
    return [self randomStringOfLength:15];
}

- (NSString *)convertToCapitalizedCamelCase
{
    return [NSString stringWithFormat:@"%@", [[self capitalizedString] stringByReplacingOccurrencesOfString:@" " withString:@""]];
}

- (NSString *)convertFromCamelCase
{
    NSMutableString *result = [NSMutableString string];
    
    for (NSInteger i=0; i < [self length]; i++){
        NSString *ch = [self substringWithRange:NSMakeRange(i, 1)];
        if ([ch rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound) {
            [result appendString:@" "];
        }
        [result appendString:ch];
    }
    return [result trimWhiteSpace];
}

- (NSString *)stringByRemovingLastCharacter
{
    return [self substringToIndex:self.length-(self.length>0)];
}

@end
