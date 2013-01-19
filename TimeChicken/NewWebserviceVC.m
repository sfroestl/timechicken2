//
//  NewWebserviceVC.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "NewWebserviceVC.h"
#import "TCWebservice.h"
#import "TCWSOneSpark.h"
#import "WebserviceEditVC.h"

@interface NewWebserviceVC ()

@end

@implementation NewWebserviceVC

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return ([[TCWebservice webserviceNames] count] - 1);}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WSCell"];
    }
    [[cell textLabel] setText:[[TCWebservice webserviceNames] objectAtIndex:indexPath.row + 1]];
    [[cell detailTextLabel] setText:[[TCWebservice webserviceDescriptions] objectAtIndex:indexPath.row + 1]];
    [[cell imageView] setImagePath: [UIImage imageNamed:[[TCWebservice webserviceImages] objectAtIndex:indexPath.row + 1]]];
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebserviceEditVC *wsDetailVC = [[WebserviceEditVC alloc] init];
    TCWebservice *webservice;
    switch (indexPath.row) {
        case 0:
            webservice = [[TCWSOneSpark alloc] init];
            wsDetailVC.detailItem = webservice;
            break;
        case 1:
            break;
    }
    [[self navigationController] pushViewController:wsDetailVC animated:YES];
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



@end
