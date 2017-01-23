//
//  NSArray+functions.m
//  KZPUtilities
//
//  Created by Matt Rankin on 17/07/2014.
//  Copyright (c) 2014 Matt Rankin. All rights reserved.
//

#import "NSArray+functions.h"

@implementation NSArray (functions)

- (NSInteger)sum
{
    int s = 0;
    for (id element in self) {
        if (![element respondsToSelector:@selector(intValue)]) {
            return 0;
        }
        s += [element intValue];
    }
    return s;
}

- (NSUInteger)absSum
{
    NSUInteger s = 0;
    for (id element in self) {
        if (![element respondsToSelector:@selector(intValue)]) {
            return 0;
        }
        s += abs([element intValue]);
    }
    return s;
}

- (NSInteger)findInt:(int)target
{
    for (int i = 0; i < [self count]; i++) {
        if ([self[i] respondsToSelector:@selector(intValue)]) {
            if ([self[i] intValue] == target) return i;
        }
    }
    return -1;
}

- (NSString *)oneLineDescriptionUsingDelimiter:(NSString *)delimiter
{
    NSMutableString *arrayString = [[NSMutableString alloc] init];
    for (int i = 0; i < [self count]; i++) {
        id element = self[i];
        NSString *elementString = [element description];
        if ([elementString length] > 0) {
            [arrayString appendString:elementString];
            if (i < [self count] - 1) {
                [arrayString appendString:delimiter];
            }
        }
    }
    return arrayString;
}

- (NSUInteger)findNumber:(NSNumber *)number
{
    for (int i = 0; i < [self count]; i++) {
        if ([self[i] isKindOfClass:[NSNumber class]]) {
             if ([self[i] intValue] == [number intValue]) return i;
        }
    }
    return -1;
}

- (NSArray *)reverse
{
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)flatten
{
    NSArray *flattenedArray = [NSArray array];
    for (id element in self) {
        if ([element isKindOfClass:[NSArray class]]) {
            flattenedArray = [flattenedArray arrayByAddingObjectsFromArray:element];
        } else {
            flattenedArray = [flattenedArray arrayByAddingObject:element];
        }
    }
    return flattenedArray;
}

- (NSArray *)makeSubArrays
{
    NSArray *arrayWithSubarrays = [NSArray array];
    for (id element in self) {
        if ([element isKindOfClass:[NSArray class]]) {
            arrayWithSubarrays = [arrayWithSubarrays arrayByAddingObject:element];
        } else {
            arrayWithSubarrays = [arrayWithSubarrays arrayByAddingObject:@[element]];
        }
    }
    return arrayWithSubarrays;
}

+ (NSArray *)arrayWithElement:(id)element repetitions:(unsigned int)count
{
    if (!element) return nil;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [array addObject:element];
    }
    return [NSArray arrayWithArray:array];
}

- (BOOL)areAll:(Class)requiredClass
{
    if (!requiredClass || [self count] == 0) return NO;
    for (id element in self) {
        if (![element isKindOfClass:requiredClass]) {
            return NO;
        }
    }
    return YES;
}

- (NSArray *)alphabetize
{
    return [self sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (int)absMin
{
    int min = INT_MAX;
    for (id element in self) {
        if ([element respondsToSelector:@selector(intValue)]) {
            int intValue = abs([element intValue]);
            if (intValue < min) min = intValue;
        }
    }
    return min;
}

- (int)absMax
{
    int max = 0;
    for (id element in self) {
        if ([element respondsToSelector:@selector(intValue)]) {
            int intValue = abs([element intValue]);
            if (intValue > max) max = intValue;
        }
    }
    return max;
}

@end
