//
//  NSMutableSet+functions.m
//  KZPUtilities
//
//  Created by Matthew Rankin on 24/04/2016.
//  Copyright © 2016 Sudoseng. All rights reserved.
//

#import "NSMutableSet+functions.h"

@implementation NSMutableSet (functions)

- (void)addObjectsFromArrayWithoutDuplication:(NSArray *)array
{
    for (id element in array) {
        if (![self containsObject:element]) {
            [self addObject:element];
        }
    }
}

@end
