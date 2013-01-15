//
//  SecondViewController.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WebserviceListViewController.h"
#import "TCWebserviceStore.h"
#import "TCWebservice.h"
#import "TCWSOneSpark.h"

@interface WebserviceListViewController ()

@end

@implementation WebserviceListViewController

							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) init
{
    //call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        self.title = @"Webservice";
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewWebservice:)];
        
        // Set this bar button item as the right item in navigation
        [[self navigationItem] setRightBarButtonItem:bbi];
        
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[TCWebserviceStore webservices] allWebservices] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create an instance of UITableViewCell, with default appearance
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WebserviceCell"];
    
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WebserviceCell"];
    }
    TCWebservice *ws = [[[TCWebserviceStore webservices] allWebservices] objectAtIndex:[indexPath row]];
    
    [cell.textLabel setText: ws.title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected Webservice");
    TCWebservice *selectedWS = [[[TCWebserviceStore webservices] allWebservices] objectAtIndex:[indexPath row]];
    
    if ([selectedWS isKindOfClass:[TCWSOneSpark class]]) {
        NSLog(@"Webservice is TCWSOneSpark!");
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[TCWebserviceStore webservices] moveItemAtIndex:[fromIndexPath row]toIndex:[toIndexPath row]];
}

- (IBAction)addNewWebservice:(id)sender {
    // Create a new BNRItem and add it to the store
    TCWebservice *newWS = [[TCWebserviceStore webservices] createNewWebservice];
    
    // Figure out where that item is in the array
    int lastRow = [[[TCWebserviceStore webservices] allWebservices] indexOfObject:newWS];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // insert new row into table
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip ] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TCWebserviceStore *wsStore = [TCWebserviceStore webservices];
        NSArray *wsList = [wsStore allWebservices];
        TCWebservice *ws = [wsList objectAtIndex:[indexPath row]];
        [wsStore removeWebservice:ws];
        
        // We also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)fetchTasksForWebservice: (TCWebservice *) webservice {
    
}

@end
