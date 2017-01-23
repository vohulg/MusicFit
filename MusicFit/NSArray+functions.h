//
//  NSArray+functions.h
//  KZPUtilities
//
//  Created by Matt Rankin on 17/07/2014.
//  Copyright (c) 2014 Matt Rankin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (functions)

- (NSArray *)alphabetize;
- (NSUInteger)absSum;
- (int)absMin;
- (int)absMax;
- (NSInteger)sum;
- (NSString *)oneLineDescriptionUsingDelimiter:(NSString *)delimiter;
- (NSUInteger)findNumber:(NSNumber *)number;
- (NSArray *)reverse;
- (NSArray *)flatten;
- (NSArray *)makeSubArrays;
+ (NSArray *)arrayWithElement:(id)element repetitions:(unsigned int)count;
- (BOOL)areAll:(Class)requiredClass;
- (NSInteger)findInt:(int)target;

@end
