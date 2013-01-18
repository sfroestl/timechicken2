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

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        self.title = @"Tasks";
//        for (int i=0; i<5; i++){
//            [[TCTaskStore taskStore] createNewTask];
//        }
//        // Custom initialization
//    }
//    return self;
//}

- (id) init{
    //call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        self.title = @"Tasks";
        NSDate *date = [[NSDate alloc] init];
        TCTask *taskWithImage = [[TCTask alloc] initWithTitle:@"ImageTask" desc:@"shows image and date" project:@"TC-App-Dev" dueDate:date url:nil completed:YES wsType:0];
        [[TCTaskStore taskStore] addTask:taskWithImage];
        
        for (int i=0; i<5; i++){
            [[TCTaskStore taskStore] createNewTask];
        }
        
    }
    return self;
}

-(id) initWithStyle:(UITableViewStyle)style{
    return [self init];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

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
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Number of rows it should expect should be based on sections
    int count;
    if(section == 0) {
        count =  [[[TCTaskStore taskStore] getOpenTasks] count];
    } else if (section == 1) {
        count =  [[[TCTaskStore taskStore] getCompletedTasks] count];
    }
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0) return @"Open Tasks";
    else return @"Completed Tasks";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
//    NSArray *array = [dictionary objectForKey:@"data"];
    TCTask *task = nil;
    if (indexPath.section == 0) {
        NSArray *openTasks = [[TCTaskStore taskStore] getOpenTasks];
        task =  [openTasks objectAtIndex:indexPath.row];
    } else if(indexPath.section == 1) {
        NSArray *completedTasks = [[TCTaskStore taskStore] getCompletedTasks];
        task =  [completedTasks objectAtIndex:indexPath.row];
    }
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    //Connect TimerButton of TaskCell to this TaskListViewController and asign table
    [cell setController:self];
    [cell setTableView:tableView];
    
    //if tasktyp is onespark, show image
    if(task.wsType==1){
        [[cell thumbnailView] setImage:[UIImage imageNamed:@"onesparkThumb.png"]];
    }
    
    cell.titleLabel.text = task.title;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY.MM.dd"];
    [[cell subtitleLabel] setText:[NSString stringWithFormat:@"due: %@", [dateFormat stringFromDate:[task dueDate]]]];
    NSString *timeString = @"00:15:28";
    [[cell timeButton] setTitle:timeString forState:UIControlStateNormal];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"IndexPath = Section %u, Row %u", indexPath.section, indexPath.row);
    //Get the selected Task
    TCTask *task = nil;
    if (indexPath.section == 0) {
        task =  [[[TCTaskStore taskStore] getOpenTasks] objectAtIndex:indexPath.row];
    } else if(indexPath.section == 1) {
        task =  [[[TCTaskStore taskStore] getCompletedTasks] objectAtIndex:indexPath.row];
    }
    
    // transition to TaskDetailController
    TaskDetailVC *detailVC = [[TaskDetailVC alloc] init];
    [detailVC setDetailItem:task];
    
    [self.navigationController pushViewController:detailVC animated:YES];
//    NSlog(@"%@", selectedTask.title);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[TCTaskStore taskStore] moveTaskAtIndex:[fromIndexPath row] toIndex:[toIndexPath row]];
}

- (IBAction)addNewTask:(id)sender {
    // Create a new Task and add it to the store
    TCTask *newTask = [[TCTaskStore taskStore] createNewTask];
    
    // Figure out where that item is in the tasks array
    
    NSArray *openTasks = [[TCTaskStore taskStore] getOpenTasks];
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
