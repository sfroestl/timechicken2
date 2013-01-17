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
        TCTask *taskWithImage = [[TCTask alloc] initWithTitle:@"ImageTask" desc:@"shows image and date" project:@"TC-App-Dev" dueDate:date url:nil completed:NO wsType:1];
        [[TCTaskStore taskStore] addTaskToOpenTasks:taskWithImage];
        
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

    //initialize the dataArray
    dataArray = [[NSMutableArray alloc]init];
    
    //openTasks section data
    NSDictionary *openTasksArrayDict = [NSDictionary dictionaryWithObject:[[TCTaskStore taskStore] openTasks] forKey:@"data"];
    [dataArray addObject:openTasksArrayDict];
    
    //completedTasks section data
    NSDictionary *completedTasksArrayDict = [NSDictionary dictionaryWithObject:[[TCTaskStore taskStore] completedTasks] forKey:@"data"];
    [dataArray addObject:completedTasksArrayDict];
    
    
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
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Number of rows it should expect should be based on sections
    NSDictionary *dictinary = [dataArray objectAtIndex:section];
    NSArray *array = [dictinary objectForKey:@"data"];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0) return @"Open Tasks";
    else return @"Completed Tasks";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    TCTask *task =  [array objectAtIndex:indexPath.row];
    
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    //Connect TimerButton of TaskCell to this TaskListViewController and asign table
    [cell setController:self];
    [cell setTableView:tableView];
    
    //if tasktyp is onespark, show image
    if(task.wsType==1){
        [[cell thumbnailView] setImage:[UIImage imageNamed:@"onesparkThumb.png"]];
    }
    
    [[cell titleLabel] setText:[task title]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE YYYY.MM.dd"];
    [[cell subtitleLabel] setText:[NSString stringWithFormat:@"dueDate: %@", [dateFormat stringFromDate:[task dueDate]]]];
    NSString *timeString = @"00:15:28";
    [[cell timeButton] setTitle:timeString forState:nil];    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Get the selected Task
    TCTask *selectedTask = nil;
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    selectedTask = [array objectAtIndex:indexPath.row];
    
    // transition to TaskDetailController
    TaskDetailVC *detailVC = [[TaskDetailVC alloc] init];
    [detailVC setDetailItem:selectedTask];
    
    [self.navigationController pushViewController:detailVC animated:YES];
//    NSlog(@"%@", selectedTask.title);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[TCTaskStore taskStore] moveTaskAtIndexInOpenTasks:[fromIndexPath row] toIndex:[toIndexPath row]];
}

- (IBAction)addNewTask:(id)sender {
    // Create a new Task and add it to the store
    TCTask *newTask = [[TCTaskStore taskStore] createNewTask];
    
    // Figure out where that item is in the openTasks array
    int lastRow = [[[TCTaskStore taskStore] openTasks] indexOfObject:newTask];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // insert new row into table
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip ] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        TCTaskStore *taskStore = [TCTaskStore   taskStore];
        NSArray *taskList = [taskStore openTasks];
        TCTask *task = [taskList objectAtIndex:[indexPath row]];
        [taskStore removeTaskFromOpenTasks:task];
        
        // We also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)startStopTimer:(id)sender atIndexPath:(NSIndexPath *)ip{
    NSLog(@"Going to start/stop the Timer for %@", ip);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

//}

@end
