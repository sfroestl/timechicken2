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
    NSMutableArray *archivedTasks;
}

+ (TCTaskStore *) taskStore;

- (NSArray *) tasks;
- (NSArray *) archivedTasks;

- (TCTask *) createNewTask;

- (void) addTask:(TCTask *)task;
- (void) addTask:(TCTask *)task fromURL: (NSString *)URLString;
- (void) addTasks:(NSArray *)listOfTasks;

- (void) addTaskToArchivedTasks:(TCTask *)task;
- (void) addTasksToArchivedTasks:(NSArray *)listOfTasks;

- (void) removeTask:(TCTask *)task;
- (void) removeTaskFromArchivedTasks:(TCTask *)task;

- (void) moveTaskAtIndex:(int)from toIndex:(int)to;
- (void) moveTaskAtIndexInArchivedTasks:(int)from toIndex:(int)to;

- (NSArray *) getOpenTasks;
- (NSArray *) getCompletedTasks;

- (NSArray *) findByWsType:(int) wsType;
- (NSArray *) findByWsId:(int) wsId andwsType:(int) wsType;

@end
