//
//  WSTaskChooseVCViewController.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "ChooseTaskVC.h"
#import "TCTask.h"
#import "TCTaskStore.h"
#import "TaskListVC.h"

@interface ChooseTaskVC ()

@end

@implementation ChooseTaskVC

@synthesize chosedTasksForImport = _chosedTasksForImport;
@synthesize alreadyImportedTasks = _alreadyImportedTasks;

- (void) setWsTasks:(NSArray *) tasks{
    wsTasks = tasks;
}

- (id)init
{
    //call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if(self){
        self.title = @"Choose Tasks for import";
        self.chosedTasksForImport = [[NSMutableArray alloc] init];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Import" style:UIBarButtonItemStylePlain target:self action:@selector(importWSTasks:)];
        // Set this bar button item as the right item in navigation
        [[self navigationItem] setRightBarButtonItem:bbi];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [self init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.alreadyImportedTasks = [[TCTaskStore taskStore] findByWsType:1];
    NSLog(@"Already Imported %@", self.alreadyImportedTasks);
    [[self tableView] reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"WSChooseVC: Tasks count = %u", [wsTasks count]);
    return [wsTasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCTask *wsTask = [wsTasks objectAtIndex:[indexPath row]];
    NSArray *alreadyImportedTasks = [[TCTaskStore taskStore] findByWsId:wsTask.wsID andwsType:wsTask.wsType];
    
    UITableViewCell *cell;

    BOOL found = NO;
    for (TCTask *task in alreadyImportedTasks){
        if([task.url isEqualToString:wsTask.url]){
            found = YES;
            break;
        }
    }
    if (!found) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"WSTaskCell"];
        // Ceck if Taks is already imported
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WSTaskCell"];            
            cell.userInteractionEnabled = YES;
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"WSTaskCellDisabled"];
        // Ceck if Taks is already imported
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WSTaskCellDisabled"];
            cell.userInteractionEnabled = NO;
        }
    }
    [cell.textLabel setText: wsTask.title];
    if ([self.chosedTasksForImport containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
    return cell;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TCTask *task = [wsTasks objectAtIndex:[indexPath row]];
    NSLog(@"--> Task selected: %@", task);
    if ([self.chosedTasksForImport containsObject:task])
    {
        [self.chosedTasksForImport removeObject:task];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        NSLog(@"--> Adding Task for import!!");
        [self.chosedTasksForImport addObject:task];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void) importWSTasks:(id)sender {
    NSLog(@"Import %u tasks!", [self.chosedTasksForImport count]);
    if ([self.chosedTasksForImport count] == 0) {
        UIAlertView *noTasksSelectedAlert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Please select tasks for import!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [noTasksSelectedAlert show];
        return;
    }
    // Import tasks to TCTaskStore
    [[TCTaskStore taskStore] addTasks:self.chosedTasksForImport];
    [self.chosedTasksForImport removeAllObjects];
    wsTasks = nil;
//    TaskListVC *taskVC = [self.tabBarController.viewControllers objectAtIndex:0];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully importet tasks." message:nil delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles:nil];
    [alert show];    
    [self.parentViewController.tabBarController setSelectedIndex:0];
}



@end
