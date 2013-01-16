//
//  TaskDetailVC.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TaskDetailVC.h"
#import "TCTask.h"

@interface TaskDetailVC ()

@end

@implementation TaskDetailVC

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
    
    //initialize the dataArray
    taskDetailsArray = [[NSMutableArray alloc]init];
    
    
    
    if(self.detailItem) {
        NSArray *detailsArray = [[NSArray alloc] initWithObjects: self.detailItem.title, self.detailItem.project, self.detailItem.workedTime, self.detailItem.desc, self.detailItem.dueDate, nil];
        NSDictionary *detailsArrayDict = [NSDictionary dictionaryWithObject:detailsArray forKey:@"data"];
        [taskDetailsArray addObject:detailsArrayDict];
    }
    
    //TODO: Implement TimeSessionArray
    
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [taskDetailsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Number of rows it should expect should be based on sections
    NSDictionary *dictinary = [taskDetailsArray objectAtIndex:section];
    NSArray *array = [dictinary objectForKey:@"data"];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0) return self.detailItem.title;
    else return @"Time Sessions";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // Configure the cell...
//    
//    return cell;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    UITableViewCell *cell = [tableView dequ]
    //If there is no reusable cell of this type, create a new one
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictionary = [taskDetailsArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    NSObject *cellvalue = [array objectAtIndex:indexPath.row];
    if ([cellvalue isKindOfClass:[NSString class]]) {
        cell.textLabel.text = cellvalue;
    }
    if([cellvalue isKindOfClass:[NSDate class]]){
        cell.textLabel.text = @"%d",cellvalue;
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

@end
