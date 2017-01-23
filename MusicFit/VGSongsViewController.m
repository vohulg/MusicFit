//
//  VGSongsViewController.m
//  MusicFit
//
//  Created by Admin on 13/01/17.
//  Copyright © 2017 vohulg. All rights reserved.
//

#import "VGSongsViewController.h"
#import "VGLesson+CoreDataClass.h"
#import "VGSong+CoreDataClass.h"
#import "VGLessonType+CoreDataClass.h"
#import "VGAudioPlayViewController.h"

@interface VGSongsViewController ()

@end

@implementation VGSongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Current lesson name %@ \n", self.currentLesson.name);
    [self.tableView reloadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - actions

- (nullable NSIndexPath *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    VGAudioPlayViewController* audioPlayController = [self.storyboard instantiateViewControllerWithIdentifier:@"VGAudioPlayViewController"];
    VGSong* song = [self.fetchedResultsController objectAtIndexPath:indexPath];
    audioPlayController.currentSong = song;
    
    [self showViewController:audioPlayController sender:self];     
    
    return nil;
}






#pragma mark - NSFetchedResultController

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController *)fetchedResultsController
{
   
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
        
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VGSong" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nameSong" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Set predicate
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"lesson.name == %@ AND lesson.lessonType.lessonType == %d", self.currentLesson.name, self.currentLesson.lessonType.lessonType];
    
    //NSPredicate* predicate = [NSPredicate predicateWithFormat:@"lesson.seq == %d", self.currentLesson.seq];
    [fetchRequest setPredicate:predicate];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSLog(@"VGLOG_5:_fetchedResultsController runned");
    
    return _fetchedResultsController;
}



- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object {
    
    VGSong* song = (VGSong*) object;
    cell.textLabel.text = song.nameSong;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

}








@end
