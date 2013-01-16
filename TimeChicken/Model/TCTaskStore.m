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
        openTasks = [[NSMutableArray alloc] init];
        completedTasks = [[NSMutableArray alloc] init];
        archivedTasks = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *) openTasks {
//    NSLog(@"Open Tasks: %@", openTasks);
    return openTasks;
}
- (NSArray *) completedTasks {
    return completedTasks;
}
- (NSArray *) archivedTasks {
    return archivedTasks;
}

- (TCTask *) createNewTask {
    TCTask *newTask = [[TCTask alloc] initWithTitle:@"New Task"];
    [openTasks addObject:newTask];
    return newTask;
}

- (void) addTaskToOpenTasks:(TCTask *)task {
    
    [openTasks addObject:task];
}
- (void) addTaskToCompletedTasks:(TCTask *)task {
    //extend with check, if task is in other arrays and remove it there, if it is added to completedTasks
    [completedTasks addObject:task];
}
- (void) addTaskToArchivedTasks:(TCTask *)task {
    [archivedTasks addObject:task];
}



- (void) removeTaskFromOpenTasks:(TCTask *)task {
    [openTasks removeObjectIdenticalTo:task];
}
- (void) removeTaskFromCompletedTasks:(TCTask *)task {
    [completedTasks removeObjectIdenticalTo:task];
}
- (void) removeTaskFromArchivedTasks:(TCTask *)task {
    [archivedTasks removeObjectIdenticalTo:task];
}

- (void) moveTaskAtIndexInOpenTasks:(int)from toIndex:(int)to {
    if (from == to){
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    TCTask *task = [openTasks objectAtIndex:from];
    // Remove item from array
    [openTasks removeObjectAtIndex:from];    
    // Insert item in array at new location
    [openTasks insertObject:task atIndex:to];
}
- (void) moveTaskAtIndexInCompletedTasks:(int)from toIndex:(int)to {
    if (from == to) {
        return;
    }
    TCTask *task = [completedTasks objectAtIndex:from];
    [completedTasks removeObjectAtIndex:from];
    [completedTasks insertObject:task atIndex:to];
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
