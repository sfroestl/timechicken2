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
        
        //if the array hadn't be saved previously, creae a new empty one
        if(!tasks){
            tasks = [[NSMutableArray alloc] init];
//            TCTask *firstTask = [[TCTask alloc] initWithTitle:@"Nerdy coding" desc:@"Heloooo asdjasdjh asdo aosdhj iashdo as" projectTitle:@"Wuppi" dueDate:[NSDate date]];
//
//            TCTimeSession *session1 = [[TCTimeSession alloc] initWithStart:[NSDate dateWithTimeIntervalSince1970:1358755421000]];
//            session1.end = [NSDate dateWithTimeIntervalSince1970:1358780400000];
//            TCTimeSession *session2 = [[TCTimeSession alloc] initWithStart:[NSDate dateWithTimeIntervalSince1970:1358924400000]];
//            session2.end = [NSDate dateWithTimeIntervalSince1970:1358953221000];
//            
//            [firstTask.timeSessions addObject:session1];
//            [firstTask.timeSessions addObject:session2];
            
//            [tasks addObject:firstTask];
            
        }
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

- (void) addTask:(TCTask *)task fromURL: (NSString *)URLString {
    task.url = URLString;
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

- (void) completeTask:(TCTask *)task {
    task.completed = YES;
    task.completedAt = [NSDate date];
}

- (void) reopenTask:(TCTask *)task {
    task.completed = NO;
    task.completedAt = nil;
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

- (NSArray *) findByWsId:(int) wsId {
    NSPredicate *condition = [NSPredicate predicateWithFormat:@"wsID == %i", wsId];
    NSArray *foundTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:condition];
    return foundTasks;
}
- (NSArray *) findByWsType:(int) wsType {
    NSPredicate *condition = [NSPredicate predicateWithFormat:@"(wsType == %i)", wsType];
    NSArray *foundTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:condition];
    return foundTasks;
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
