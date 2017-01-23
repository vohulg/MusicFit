//
//  NSDictionary+PList.h
//  KZPNameTone
//
//  Created by Matthew Rankin on 14/10/2015.
//  Copyright © 2015 Sudoseng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PList)

+ (NSDictionary *)dictionaryFromPlist:(NSString *)plistName;

@end
