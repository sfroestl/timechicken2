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
    NSMutableArray *tasks;
    NSMutableArray *completedTasks;
    NSMutableArray *archivedTasks;
}

+ (TCTaskStore *) taskStore;

-(NSString *)taskArchivePath;
-(BOOL) saveChanges;

- (NSArray *) tasks;
- (NSArray *) archivedTasks;
- (NSArray *) completedTasks;

- (TCTask *) createNewTask;

- (void) addTask:(TCTask *)task;
- (void) addTasks:(NSArray *)listOfTasks;

- (void) addTaskToArchivedTasks:(TCTask *)task;
- (void) addTasksToArchivedTasks:(NSArray *)listOfTasks;

- (void) completeTask:(TCTask *)task;
- (void) reopenTask:(TCTask *)task;

- (void) removeTask:(TCTask *)task;
- (void) removeTaskFromArchivedTasks:(TCTask *)task;
- (void) removeTaskFromCompletedTasks:(TCTask *)task;
- (void) removeTasksOfWsId:(int) wsId;

- (void) moveTaskAtIndex:(int)from toIndex:(int)to;
- (void) moveTaskAtIndexInCompletedTasks:(int)from toIndex:(int)to;
- (void) moveTaskAtIndexInArchivedTasks:(int)from toIndex:(int)to;

- (NSArray *) getRunningTasks;
//- (NSArray *) getOpenTasks;
//- (NSArray *) getCompletedTasks;

- (NSArray *) findByWsType:(int) wsType;
- (NSArray *) findByWsId:(int) wsId;


@end
