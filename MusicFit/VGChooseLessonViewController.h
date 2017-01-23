//
//  VGChooseLessonViewController.h
//  MusicFit
//
//  Created by Admin on 12/28/16.
//  Copyright © 2016 vohulg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VGCoreDataViewController.h"

@interface VGChooseLessonViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *lessonListTableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeLessonSegmentControl;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (IBAction)actionChangeLessonType:(id)sender;

@end
