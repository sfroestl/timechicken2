//
//  WSTaskChooseVCViewController.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WSTaskChooseVCViewController.h"
#import "TCTask.h"
#import "TCTaskStore.h"
#import "TaskListVC.h"

@interface WSTaskChooseVCViewController ()

@end

@implementation WSTaskChooseVCViewController

@synthesize chosedTasksForImport = _chosedTasksForImport;

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
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"WSChooseVC: Tasks count=%u", [wsTasks count]);
    return [wsTasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSTaskCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WSTaskCell"];
    }
    TCTask *wsTask = [wsTasks objectAtIndex:[indexPath row]];
//    [cell.imageView setImage:ws.image];
    [cell.textLabel setText: wsTask.title];
    if ([self.chosedTasksForImport containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
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
    // Import tasks to TCTaskStore
    [[TCTaskStore taskStore] addTasks:self.chosedTasksForImport];
    [self.chosedTasksForImport removeAllObjects];
    wsTasks = nil;
//    TaskListVC *taskVC = [self.tabBarController.viewControllers objectAtIndex:0];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully importet tasks." message:nil delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles:nil];
    [alert show];
    [self.parentViewController.tabBarController setSelectedIndex:0];
    [self.navigationController popViewControllerAnimated:NO];
}



@end
