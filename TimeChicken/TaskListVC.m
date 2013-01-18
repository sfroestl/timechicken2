//
//  TaskListVC.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TaskListVC.h"
#import "TCTaskStore.h"
#import "TCTask.h"
#import "TaskDetailVC.h"

@interface TaskListVC ()

@end

@implementation TaskListVC

- (id) init{
    //call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        self.title = @"Tasks";
        NSDate *date = [[NSDate alloc] init];
        TCTask *taskWithImage = [[TCTask alloc] initWithTitle:@"ImageTask" desc:@"shows image and date" project:@"TC-App-Dev" dueDate:date url:nil completed:YES wsType:0];
        [[TCTaskStore taskStore] addTask:taskWithImage];
//        
//        for (int i=0; i<5; i++){
//            [[TCTaskStore taskStore] createNewTask];
//        }
    }
    return self;
}

-(id) initWithStyle:(UITableViewStyle)style{
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
   
    //Load the NIB-File for Custom Task-TableCell
    UINib *nib = [UINib nibWithNibName:@"TaskCell" bundle:nil];
    
    //Register this NIB which contains the cell
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TaskCell"];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTask:)];
    [[self navigationItem] setRightBarButtonItem:addButton];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //2 sections for open and completed tasks
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:{
            //returns number of open tasks
            NSPredicate *conditionFalse = [NSPredicate predicateWithFormat:@"(completed == NO) OR (completed == nil)"];
           return [[[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:conditionFalse] count];
        }
        case 1:{
            //returns number of closed tasks
            NSPredicate *conditionTrue = [NSPredicate predicateWithFormat:@"completed == YES"];
            return [[[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:conditionTrue] count];
        }
    }
    
    return -1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section){
        case 0: return @"Open Tasks";
        case 1: return @"Completed Tasks";
    }
    return nil;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TCTask *currentTask;
    
    NSPredicate *conditionFalse = [NSPredicate predicateWithFormat:@"(completed == NO) OR (completed == nil)"];
    NSArray *openTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:conditionFalse];
    
    NSPredicate *conditionTrue = [NSPredicate predicateWithFormat:@"completed == YES"];
    NSArray *completedTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:conditionTrue];
    
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    //Connect TimerButton of TaskCell to this TaskListViewController and asign table
    [cell setController:self];
    [cell setTableView:tableView];
    
    if(indexPath.section==0){
        currentTask = [openTasks objectAtIndex:indexPath.row];
        
        //set Backend-Thumbnails
        switch (currentTask.wsType) {
//            case 0:{
//                [[cell thumbnailView] setImage:nil];
//                break;
//            }
            case 1:{
                [[cell thumbnailView] setImage:[UIImage imageNamed:@"onesparkThumb.png"]];
                break;
            }
            case 2:{
                [[cell thumbnailView] setImage:[UIImage imageNamed:@"jiraThumb.png"]];
                break;
            }
            default:{
                [[cell thumbnailView] setImage:nil];
                break;
            }
        }
        
        //set title
        [[cell titleLabel] setText:[currentTask title]];
        
        //set subtitle
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY.MM.dd"];
        [[cell subtitleLabel] setText:[NSString stringWithFormat:@"due: %@", [dateFormat stringFromDate:[currentTask dueDate]]]];
        
        //set Time on Button
         NSString *timeString = @"00:15:28";
        [[cell timeButton] setTitle:timeString forState:nil];
        return cell;
    }
    
    if(indexPath.section==1){
        currentTask = [completedTasks objectAtIndex:indexPath.row];
        
        //set Backend-Thumbnails
        switch (currentTask.wsType) {
                //            case 0:{
                //                [[cell thumbnailView] setImage:nil];
                //                break;
                //            }
            case 1:{
                [[cell thumbnailView] setImage:[UIImage imageNamed:@"onesparkThumb.png"]];
                break;
            }
            case 2:{
                [[cell thumbnailView] setImage:[UIImage imageNamed:@"jiraThumb.png"]];
                break;
            }
            default:{
                [[cell thumbnailView] setImage:nil];
                break;
            }
        }
        
        //set title
        [[cell titleLabel] setText:[currentTask title]];
        
        //set subtitle
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY.MM.dd"];
        [[cell subtitleLabel] setText:[NSString stringWithFormat:@"due: %@", [dateFormat stringFromDate:[currentTask dueDate]]]];
        
        //set Time on Button
        NSString *timeString = @"00:15:28";
        [[cell timeButton] setTitle:timeString forState:nil];
        return cell;
    }
    return nil;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TCTask *selectedTask = nil;
    
    NSPredicate *conditionFalse = [NSPredicate predicateWithFormat:@"(completed == NO) OR (completed == nil)"];
    NSArray *openTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:conditionFalse];
    
    NSPredicate *conditionTrue = [NSPredicate predicateWithFormat:@"completed == YES"];
    NSArray *completedTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:conditionTrue];
    
    switch (indexPath.section) {
        case 0:{
            selectedTask = [openTasks objectAtIndex:indexPath.row];
            break;
        }
         
        case 1:{
            selectedTask = [completedTasks objectAtIndex:indexPath.row];
            break;
        }
        default: selectedTask = nil;
    }
    
    TaskDetailVC *detailVC = [[TaskDetailVC alloc] init];
    [detailVC setDetailItem:selectedTask];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[TCTaskStore taskStore] moveTaskAtIndex:[fromIndexPath row] toIndex:[toIndexPath row]];
}

- (IBAction)addNewTask:(id)sender {
    // Create a new Task and add it to the store
    TCTask *newTask = [[TCTaskStore taskStore] createNewTask];
    
    // Figure out where that item is in the opentasks array
    NSPredicate *conditionFalse = [NSPredicate predicateWithFormat:@"(completed == NO) OR (completed == nil)"];
    NSArray *openTasks = [[[TCTaskStore taskStore] tasks] filteredArrayUsingPredicate:conditionFalse];
    
    int lastRow = [openTasks indexOfObject:newTask];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // insert new row into table
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip ] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TCTaskStore *taskStore = [TCTaskStore  taskStore];
        NSArray *taskList;
        if (indexPath.section == 0) {
            taskList = [taskStore getOpenTasks];
        } else if (indexPath.section == 1) {
            taskList = [taskStore getCompletedTasks];
        }
        
        TCTask *task = [taskList objectAtIndex:[indexPath row]];
        
        [taskStore addTaskToArchivedTasks:task];
        [taskStore removeTask:task];
        
        
        // We also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)startStopTimer:(id)sender atIndexPath:(NSIndexPath *)ip{
    NSLog(@"Going to start/stop the Timer for %@", ip);
}


@end
