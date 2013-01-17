//
//  TaskDetailVC.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TaskDetailVC.h"
#import "TCTask.h"
#import "TaskDetailEditCell.h"

@interface TaskDetailVC ()

@end

@implementation TaskDetailVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"TaskDetails";
    
    //Load the NIB-File for Custom Task-TableCell
    UINib *nib = [UINib nibWithNibName:@"TaskDetailEditCell" bundle:nil];
    
    //Register this NIB which contains the cell
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TaskDetailEditCell"];
    
    
    
    
    //initialize the dataArray
//    taskDetailsArray = [[NSMutableArray alloc]init];
//    
//    
//    
//    if(self.detailItem) {
//        NSArray *detailsArray = [[NSArray alloc] initWithObjects: self.detailItem.title, self.detailItem.project, self.detailItem.workedTime, self.detailItem.desc, self.detailItem.dueDate, nil];
//        NSDictionary *detailsArrayDict = [NSDictionary dictionaryWithObject:detailsArray forKey:@"data"];
//        [taskDetailsArray addObject:detailsArrayDict];
//    }
    
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
//    return [taskDetailsArray count];
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0: return 5;
        case 1: return [self.detailItem.timeSessions count];
    }

    return -1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section)
    {
        case 0: return nil;
        case 1: return @"Time Sessions";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        TaskDetailEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskDetailEditCell"];
        
        switch(indexPath.row)
        {
            case 0:{
                [[cell keyLabel] setText:@"Title"];
                [[cell valueTextfield] setText:self.detailItem.title];
                return cell;
            }
            case 1:{
                [[cell keyLabel] setText:@"Project"];
                [[cell valueTextfield] setText:self.detailItem.project];
                return cell;
            }
            case 2:{
                [[cell keyLabel] setText:@"Description"];
                [[cell valueTextfield] setText:self.detailItem.desc];
                return cell;
            }
            case 3:{
                [[cell keyLabel] setText:@"Due Date"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY.MM.dd"];                
                [[cell valueTextfield] setText:[dateFormat stringFromDate:self.detailItem.dueDate]];
                return cell;
            }
            case 4:{
                [[cell keyLabel] setText:@"worked Time"];
                [[cell valueTextfield] setText:[NSString stringWithFormat:@"%d", self.detailItem.workedTime]];
                return cell;
            }
        }

    }
    
    if(indexPath.section == 1){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = @"bla";
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
    
    
//
//
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////    UITableViewCell *cell = [tableView dequ]
//    //If there is no reusable cell of this type, create a new one
//    if(!cell){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    NSDictionary *dictionary = [taskDetailsArray objectAtIndex:indexPath.section];
//    NSArray *array = [dictionary objectForKey:@"data"];
//    NSObject *cellvalue = [array objectAtIndex:indexPath.row];
//    if ([cellvalue isKindOfClass:[NSString class]]) {
//        cell.textLabel.text = cellvalue;
//        cell.detailTextLabel.text = @"bla";
//    }
//    if([cellvalue isKindOfClass:[NSDate class]]){
//        cell.textLabel.text = @"%d",cellvalue;
//    }
//    return cell;
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
