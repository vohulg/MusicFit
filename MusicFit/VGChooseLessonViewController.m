//
//  VGChooseLessonViewController.m
//  MusicFit
//
//  Created by Admin on 12/28/16.
//  Copyright © 2016 vohulg. All rights reserved.
//

#import "VGChooseLessonViewController.h"
#import "VGLesson+CoreDataClass.h"
#import "VGDataHelper.h"
#import "VGConstants.h"
#import "VGSongsViewController.h"
#import "VGLessonType+CoreDataClass.h"

@interface VGChooseLessonViewController ()

@property (strong, nonatomic) NSArray* lessonsArray;

@end

@implementation VGChooseLessonViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[VGDataHelper sharedDataHelper] deleteModel:@"musicFitModel.sqlite"];
    self.lessonsArray = [self fetchLessons];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*) fetchLessons {
    
    
     [[VGDataHelper sharedDataHelper] checkAndInitDb];
    
    // check which tap active and get array
    NSInteger lessonType = self.typeLessonSegmentControl.selectedSegmentIndex;
    
    
    NSArray* lessonArray =   [[VGDataHelper sharedDataHelper] getLessonsArray:lessonType];
    if (!lessonArray){
        lessonArray = [[NSArray alloc] init];
    }
    
    self.lessonsArray = lessonArray;
    
    [self.lessonListTableView reloadData];
    
    return lessonArray;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"numberOfRowsInSection:%ld \n ", self.lessonsArray.count);
    return self.lessonsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [self fillCell:cell andIndexPath:indexPath];
    return cell;
}


// fill cell with data from core data
-(void) fillCell:(UITableViewCell*) cell andIndexPath:(NSIndexPath*) indexPath {
    
    VGLesson* lesson = [self.lessonsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = lesson.name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}


- (nullable NSIndexPath *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   VGSongsViewController* songsController = [self.storyboard instantiateViewControllerWithIdentifier:@"VGSongsViewController"];
   VGLesson* lesson = [self.lessonsArray objectAtIndex:indexPath.row];
   songsController.currentLesson = lesson;
    
    [self showViewController:songsController sender:self];
    
    return indexPath;
}


#pragma mark - actions


- (IBAction)actionChangeLessonType:(id)sender {
      [self fetchLessons];
}
@end
