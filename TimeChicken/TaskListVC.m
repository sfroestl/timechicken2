//
//  TaskListVC.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TaskListVC.h"

#import "UIColor+TimeChickenAdditions.h"
#import "UIButton+TimeChickenAdditions.h"
#import "TCTaskStore.h"
#import "TCTask.h"
#import "TaskDetailVC.h"
#import "TCWebserviceStore.h"

//only for mocking a Task purpose
#import "TCTimeSession.h"

@interface TaskListVC ()

@end

@implementation TaskListVC

- (id) init{
    //call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        self.title = @"Tasks";
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
    self.tableView.backgroundColor = [UIColor tcMetallicColor];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    int count = 0;
    
    if(section == 1 && ([[[TCTaskStore taskStore] getCompletedTasks] count] != 0)){
        count = 35;
    }
    return count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *customTitleView = nil;
    
    if(section == 1 && ([[[TCTaskStore taskStore] getCompletedTasks] count] != 0)){
        NSString *title = @"Completed Tasks";    
        customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
        UILabel *titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.shadowColor = [UIColor whiteColor];
        titleLabel.shadowOffset = CGSizeMake(0.75, 1.0);
        titleLabel.backgroundColor = [UIColor clearColor];
        [customTitleView addSubview:titleLabel];
    }
    
    return customTitleView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:{
            return [[[TCTaskStore taskStore] getOpenTasks] count];
        }
        case 1:{
            return [[[TCTaskStore taskStore] getCompletedTasks] count];
        }
    }
    
    return -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    TCTask *currentTask;
    
    if(indexPath.section == 0){
        NSArray *openTasks = [[TCTaskStore taskStore] getOpenTasks];
        currentTask = [openTasks objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        NSArray *completedTasks = [[TCTaskStore taskStore] getCompletedTasks];
        currentTask = [completedTasks objectAtIndex:indexPath.row];
    }
    cell.backgroundColor = [UIColor whiteColor];
    //set Webservice-Thumbnails
    [cell.thumbnailView setImage: [UIImage imageNamed:[[TCWebserviceStore wsStore] wsImageOfType:currentTask.wsType]]];
    
    //set title
    [[cell titleLabel] setText:[currentTask title]];
    
    //set subtitle
    if (currentTask.dueDate) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd.MM.YYYY - HH:mm"];
        cell.subtitleLabel.text = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:[currentTask dueDate]]];
    } else {
        cell.subtitleLabel.text = [NSString stringWithFormat:@"no due date"];
    }
    int workedTimeInseconds = [currentTask calculateWorkedTimeInSeconds];
    if (workedTimeInseconds != 0) {
        cell.woredTimeLabel.text = [currentTask workedTimeAsString2];
    } else {
        cell.woredTimeLabel.text = @"0 h";
    }
    if ([currentTask isWorking]) {
        [cell.workedLabel setTextColor:[UIColor tcGreenColor]];
        cell.workedLabel.text = @"working";
    } else {
        [cell.workedLabel setTextColor:[UIColor grayColor]];
         cell.workedLabel.text = @"worked:";
    }

    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TCTask *selectedTask = nil;
    
    NSArray *completedTasks = [[TCTaskStore taskStore] getCompletedTasks];
    NSArray *openTasks = [[TCTaskStore taskStore] getOpenTasks];
    
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

# pragma mark Actions

- (IBAction)addNewTask:(id)sender {
    // Create a new Task and add it to the store
    TCTask *newTask = [[TCTaskStore taskStore] createNewTask];
    
    // Figure out where that item is in the opentasks array
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
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



@end
