//
//  VGSongsViewController.h
//  MusicFit
//
//  Created by Admin on 13/01/17.
//  Copyright © 2017 vohulg. All rights reserved.
//

#import "VGCoreDataViewController.h"
#import "VGLesson+CoreDataClass.h"

@interface VGSongsViewController : VGCoreDataViewController

@property (strong, nonatomic) VGLesson* currentLesson;
@end
