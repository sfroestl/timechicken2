//
//  TCTaskStore.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 11.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCTaskStore.h"
#import "TCTask.h"

@implementation TCTaskStore

// returns a singelton of TCTaskStore
+ (TCTaskStore *) taskStore {
    static TCTaskStore *tasksStore = nil;
    if(!tasksStore)
        tasksStore = [[super allocWithZone:nil] init];
    return tasksStore;    
}

+ (id)allocWithZone:(NSZone *)zone  {
    return [self taskStore];
}

- (id)init {
    self = [super init];
    if(self) {
        tasks = [[NSMutableArray alloc] init];
        archivedTasks = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *) getOpenTasks {
    NSPredicate *condition = [NSPredicate predicateWithFormat:@"(completed == NO) OR (completed == nil)"];
    NSArray *openTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:condition];
    return openTasks;
}

- (NSArray *) getCompletedTasks {
    NSPredicate *condition = [NSPredicate predicateWithFormat:@"(completed == YES)"];
    NSArray *openTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:condition];
    return openTasks;    
}

- (NSArray *) tasks {
    NSLog(@"%@", tasks);
    return tasks;
}
- (NSArray *) archivedTasks {
    return archivedTasks;
}

- (TCTask *) createNewTask {
    TCTask *newTask = [[TCTask alloc] initWithTitle:@"New Task"];
    [tasks addObject:newTask];
    return newTask;
}

- (void) addTask:(TCTask *)task {    
    [tasks addObject:task];
}

- (void) addTasks:(NSArray *)listOfTasks {
    //extend with check, if task is in other arrays and remove it there, if it is added to completedTasks
    [tasks addObjectsFromArray:listOfTasks];
}

- (void) addTaskToArchivedTasks:(TCTask *)task {
    [archivedTasks addObject:task];
}

- (void) addTasksToArchivedTasks:(NSArray *)listOfTasks {
    [archivedTasks addObjectsFromArray:listOfTasks];
}

- (void) removeTask:(TCTask *)task {
    [tasks removeObjectIdenticalTo:task];
}
- (void) removeTaskFromArchivedTasks:(TCTask *)task {
    [archivedTasks removeObjectIdenticalTo:task];
}

- (void) moveTaskAtIndex:(int)from toIndex:(int)to {
    if (from == to){
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    TCTask *task = [tasks objectAtIndex:from];
    // Remove item from array
    [tasks removeObjectAtIndex:from];
    // Insert item in array at new location
    [tasks insertObject:task atIndex:to];
}

- (void) moveTaskAtIndexInArchivedTasks:(int)from toIndex:(int)to{
    if (from == to) {
        return;
    }
    TCTask *task = [archivedTasks objectAtIndex:from];
    [archivedTasks removeObjectAtIndex:from];
    [archivedTasks insertObject:task atIndex:to];
}

@end
