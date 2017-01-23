//
//  NSDictionary+PList.m
//  KZPNameTone
//
//  Created by Matthew Rankin on 14/10/2015.
//  Copyright © 2015 Sudoseng. All rights reserved.
//

#import "NSDictionary+PList.h"

@implementation NSDictionary (PList)

+ (NSDictionary *)dictionaryFromPlist:(NSString *)plistName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}

@end
