//
//  VGCoreDataViewController.h
//  CoreDataBase
//
//  Created by Admin on 12/2/16.
//  Copyright © 2016 vohulg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface VGCoreDataViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object;



@end
