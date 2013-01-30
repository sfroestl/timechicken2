//
//  TCTaskStore.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 11.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCTaskStore.h"
#import "TCTask.h"
#import "TCTimeSession.h"

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
        NSString *path = [self taskArchivePath];
        tasks = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if(!tasks){
            tasks = [[NSMutableArray alloc] init];
        }
        if(!completedTasks) {
            completedTasks = [[NSMutableArray alloc] init];
        }
        if(!archivedTasks) {
            archivedTasks = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

//- (NSArray *) getOpenTasks {
//    NSPredicate *condition = [NSPredicate predicateWithFormat:@"(completed == NO) OR (completed == nil)"];
//    NSArray *openTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:condition];
//    return tasks;
//}
//
//- (NSArray *) getCompletedTasks {
//    NSPredicate *condition = [NSPredicate predicateWithFormat:@"(completed == YES)"];
//    NSArray *completedTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:condition];
//    for (TCTask *task in completedTasks) {
//        NSLog(@"## Completed Task %@ index: %u", task.title, [tasks indexOfObjectIdenticalTo:task]);
//    }
//    return completedTasks;
//}

- (NSArray *) tasks {
    return tasks;
}
- (NSArray *) archivedTasks {
    return archivedTasks;
}
- (NSArray *) completedTasks {
    return completedTasks;
}

- (TCTask *) createNewTask {
    TCTask *newTask = [[TCTask alloc] initWithTitle:@"New Task"];
    [tasks insertObject: newTask atIndex:0];
    return newTask;
}

- (void) addTask:(TCTask *)task {
    if ([task isCompleted]) {
        [completedTasks addObject:task];
    } else {
        [tasks addObject:task];
    }

}


- (void) addTasks:(NSArray *)listOfTasks {
    //extend with check, if task is in other arrays and remove it there, if it is added to completedTasks
    for (TCTask *task in listOfTasks) {
        [self addTask: task];
    }
}

- (void) addTaskToArchivedTasks:(TCTask *)task {
    [archivedTasks addObject:task];
}

- (void) addTasksToArchivedTasks:(NSArray *)listOfTasks {
    [archivedTasks addObjectsFromArray:listOfTasks];
}

- (void) completeTask:(TCTask *)task {
    task.completed = YES;
    task.completedAt = [NSDate date];
    [tasks removeObject:task];
    [completedTasks addObject:task];
}

- (void) reopenTask:(TCTask *)task {
    task.completed = NO;
    task.completedAt = nil;
    [completedTasks removeObject:task];
    [tasks addObject:task];
}

- (void) removeTask:(TCTask *)task {
    [tasks removeObjectIdenticalTo:task];
}
- (void) removeTaskFromArchivedTasks:(TCTask *)task {
    [archivedTasks removeObjectIdenticalTo:task];
}
- (void) removeTaskFromCompletedTasks:(TCTask *)task {
    [completedTasks removeObjectIdenticalTo:task];
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

- (void) moveTaskAtIndexInCompletedTasks:(int)from toIndex:(int)to {
    if (from == to){
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    TCTask *task = [completedTasks objectAtIndex:from];
    // Remove item from array
    [completedTasks removeObjectAtIndex:from];
    // Insert item in array at new location
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

- (NSArray *) findByWsId:(int) wsId {
    NSPredicate *condition = [NSPredicate predicateWithFormat:@"wsID == %i", wsId];
    NSMutableArray *allTasks = [[NSMutableArray alloc] initWithArray: [[TCTaskStore taskStore] tasks]];
    [allTasks addObjectsFromArray:[[TCTaskStore taskStore] completedTasks]];
    NSArray *foundTasks = [allTasks filteredArrayUsingPredicate:condition];
    return foundTasks;
}
- (NSArray *) findByWsType:(int) wsType {
    NSPredicate *condition = [NSPredicate predicateWithFormat:@"(wsType == %i)", wsType];
    NSMutableArray *allTasks = [[NSMutableArray alloc] initWithArray: [[TCTaskStore taskStore] tasks]];
    [allTasks addObjectsFromArray:[[TCTaskStore taskStore] completedTasks]];
    NSArray *foundTasks = [allTasks filteredArrayUsingPredicate:condition];
    return foundTasks;
}

-(NSArray * )getRunningTasks{
    NSPredicate *condition = [NSPredicate predicateWithFormat:@"timeTrackerStart != nil"];
    NSArray *runningTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:condition];
    return runningTasks;
}

-(NSString *)taskArchivePath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"tasks.archive"];
}

-(BOOL)saveChanges{
    //returning success or failure
    NSString *path = [self taskArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:tasks toFile:path];
}


@end
