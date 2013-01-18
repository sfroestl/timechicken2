//
//  TCTaskStore.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 11.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCTask;

@interface TCTaskStore : NSObject {
    NSMutableArray *openTasks;
    NSMutableArray *completedTasks;
    NSMutableArray *archivedTasks;
}

+ (TCTaskStore *) taskStore;

- (NSArray *) openTasks;
- (NSArray *) completedTasks;
- (NSArray *) archivedTasks;

- (TCTask *) createNewTask;

- (void) addTaskToOpenTasks:(TCTask *)task;
- (void) addTaskToCompletedTasks:(TCTask *)task;
- (void) addTaskToArchivedTasks:(TCTask *)task;

- (void) addTasksToOpenTasks:(NSArray *)listOfTasks;

- (void) removeTaskFromCompletedTasks:(TCTask *)task;
- (void) removeTaskFromOpenTasks:(TCTask *)task;
- (void) removeTaskFromArchivedTasks:(TCTask *)task;

- (void) moveTaskAtIndexInOpenTasks:(int)from toIndex:(int)to;
- (void) moveTaskAtIndexInCompletedTasks:(int)from toIndex:(int)to;
- (void) moveTaskAtIndexInArchivedTasks:(int)from toIndex:(int)to;



@end
