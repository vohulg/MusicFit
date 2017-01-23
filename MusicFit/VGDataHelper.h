//
//  VGDataHelper.h
//  CoreDataBase
//
//  Created by Admin on 12/2/16.
//  Copyright © 2016 vohulg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VGConstants.h"


@interface VGDataHelper : NSObject

+(VGDataHelper*) sharedDataHelper;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void) deleteModel:(NSString*) dbName;

-(NSArray*) checkAndInitDb;

-(NSArray*) getLessonsArray:(NSInteger)lessonTypeIndex;





@end
