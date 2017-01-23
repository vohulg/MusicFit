//
//  VGDataHelper.m
//  CoreDataBase
//
//  Created by Admin on 12/2/16.
//  Copyright © 2016 vohulg. All rights reserved.
//

#import "VGDataHelper.h"
#import "VGLesson+CoreDataClass.h"
#import "VGLessonType+CoreDataClass.h"
#import "VGSong+CoreDataClass.h"
#import "VGConstants.h"


@implementation VGDataHelper

+(VGDataHelper*) sharedDataHelper {

    static VGDataHelper* dataHelper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataHelper = [[VGDataHelper alloc] init];
        NSLog(@"%@", [dataHelper applicationDocumentsDirectory]);
        
    });
    
    return dataHelper;
    
}


-(void) saveChange {
    
    NSError* error = nil;
    [self.managedObjectContext save:&error];
    
    if (error){
        NSLog(@"Error by save: %@", [error localizedDescription]);
    }
    
}


-(void) deleteModel:(NSString*) dbName {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dbName];
    NSString* filePath = storeURL.absoluteString;
    filePath = [filePath substringFromIndex:7];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
     [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    NSString* tmpFilePath = [NSString stringWithFormat:@"%@-shm", filePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:tmpFilePath]){
        [[NSFileManager defaultManager] removeItemAtPath:tmpFilePath error:nil];
    }
    
    tmpFilePath = [NSString stringWithFormat:@"%@-wal", filePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:tmpFilePath]){
        [[NSFileManager defaultManager] removeItemAtPath:tmpFilePath error:nil];
    }
   
    NSLog(@"StoreUrl: %@ deleted", storeURL);
    
}


#pragma mark - INIT Database

-(NSArray*) checkAndInitDb {

    
    // check lessons list
    if (![self getEntityCount:@"VGLesson"]) {
        [self fillDbWithLessons];
    }
    
    // check lessonsType
    /*
    if (![self getEntityCount:@"VGLessonType"]){
        [self fillDbWithLessonType];
    }
     */
    
    //check songs list
    /*
    if (![self getEntityCount:@"VGSong"]){
        [self fillDbWithSongs];
    }
     */
    
    return nil;


}

-(NSUInteger) getEntityCount:(NSString*)entityName {

    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    return [self.managedObjectContext countForFetchRequest:fetchRequest error:nil];

}


//============SELECT================================

#pragma mark - Select

-(NSArray*) getLessonsArray:(NSInteger)lessonTypeIndex {

    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"VGLesson"];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"lessonType.lessonType == %ld", lessonTypeIndex];
    [request setPredicate:predicate];
    
    NSSortDescriptor* sortDescr = [NSSortDescriptor sortDescriptorWithKey:@"seq" ascending:YES];
    [request setSortDescriptors:@[sortDescr]];
    
    NSArray* result = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    return result;
}


//===============INSERT================

#pragma mark - Insert

-(NSInteger) fillDbWithLessons {
    
    //create type lessons
    VGLessonType* lessonMelody = [NSEntityDescription insertNewObjectForEntityForName:@"VGLessonType" inManagedObjectContext:self.managedObjectContext];
    lessonMelody.lessonType = eLESSON_TYPE_MELODY;
    
    VGLessonType* lessonAccompanement = [NSEntityDescription insertNewObjectForEntityForName:@"VGLessonType" inManagedObjectContext:self.managedObjectContext];
    lessonAccompanement.lessonType = eLESSON_TYPE_ACCOMPANEMENT;
    
    //create lessons
    for (int j = 0; j < 2; j++) {
    
        for (int i = 1; i < 11; i++){
            
            VGLesson* lesson = [NSEntityDescription insertNewObjectForEntityForName:@"VGLesson" inManagedObjectContext:self.managedObjectContext];
            
            lesson.name = [NSString stringWithFormat:@"Урок %d", i];
            lesson.seq = i;
            
            if(j == eLESSON_TYPE_MELODY){
                lesson.lessonType = lessonMelody;
            }
            
            if(j == eLESSON_TYPE_ACCOMPANEMENT){
                lesson.lessonType = lessonAccompanement;
            }
            
            //create song for lesson
            NSArray* songList = [self getArrayOfSongs:i andLessonTypeIndex:lesson.lessonType.lessonType];
            if (songList.count > 0){
                [self insertSongsFromArray:lesson andSongList:songList ];
            }
        }
    }
    
     [self saveChange];

    return 0;
}

-(NSArray*) getArrayOfSongs:(NSInteger) lessonIndex andLessonTypeIndex:(NSInteger)lessonTypeIndex {
    
    if (lessonTypeIndex == eLESSON_TYPE_MELODY){
        return [self getArraySongsForMelody:lessonIndex];
    }
    
    else if (lessonTypeIndex == eLESSON_TYPE_ACCOMPANEMENT) {
            return [self getArraySongsForAccompanement:lessonIndex];
    }
    
    return [[NSArray alloc] init];

}

-(NSArray*) getArraySongsForAccompanement:(NSInteger) lessonIndex {

    NSArray* songList = [[NSArray alloc] init];
    switch (lessonIndex) {
        case 1:
            songList = @[
                         @"Перебор 1",
                         @"Перебор 2",
                         @"Перебор 3",
                         ];
            break;
            
        case 2:
            songList = @[
                         @"Перебор 4",
                         @"Перебор 5",
                         @"Перебор 6",
                         ];
            break;
            
        default:
            break;
    }
    
    return songList;
}


-(NSArray*) getArraySongsForMelody:(NSInteger) lessonIndex {
    
    NSArray* songList = [[NSArray alloc] init];
    switch (lessonIndex) {
        case 1:
            songList = @[
                         @"Березка",
                         @"Во саду ли в огороде",
                         @"Жили у бабуси",
                         @"Калинка Малинка",
                         @"Маленькой елочке",
                         @"Ода к радости",
                         @"Ты же мене пидманула"
                         ];
            
            break;
            
        case 2:
            songList = @[
                         @"Катюша",
                         @"Под небом голубым",
                         @"Шар голубой",
                         @"Эх, ухнем",
                         @"Happy birthday",
                         @"In Taberna",
                         @"La serenissima"
                         ];
            break;
            
        default:
            break;
    }
    
    return songList;


}

-(NSInteger) insertSongsFromArray:(VGLesson*) lesson andSongList:(NSArray*)songNameList {
    
    
    
    
    for (NSString* songItem in songNameList){
        
       VGSong* song  = [NSEntityDescription insertNewObjectForEntityForName:@"VGSong" inManagedObjectContext:self.managedObjectContext];
       song.nameSong = songItem;
       song.lesson = lesson;
    }

    return 0;
}



//==================================================================================//

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.vohulg.CoreDataBase" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"musicFitModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"musicFitModel.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
