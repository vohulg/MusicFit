//
//  NSMutableArray+functions.m
//  KZPUtilities
//
//  Created by Matthew Rankin on 5/04/2016.
//  Copyright © 2016 Sudoseng. All rights reserved.
//

#import "NSMutableArray+functions.h"

@implementation NSMutableArray (functions)

- (void)addUniqueObject:(id)anObject
{
    if (![self containsObject:anObject]) {
        [self addObject:anObject];
    }
}

@end
