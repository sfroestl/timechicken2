//
//  SecondViewController.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WebserviceListVC.h"
#import "WebserviceDetailVC.h"
#import "TCWebserviceStore.h"
#import "TCWebservice.h"
#import "NewWebserviceVC.h"

#import "UIColor+TimeChickenAdditions.h"

@interface WebserviceListVC ()

@end

@implementation WebserviceListVC

							
- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIView *background = [[UIView alloc] init];
//	background.backgroundColor = [UIColor tcMetallicColor];
//	self.tableView.backgroundView = background;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor tcMetallicColor];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    //call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        self.title = @"Import Tasks";
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewWebservice:)];
        
        // Set this bar button item as the right item in navigation
        [[self navigationItem] setRightBarButtonItem:addButton];
        
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[TCWebserviceStore wsStore] allWebservices] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WebserviceCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WebserviceCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    TCWebservice *ws = [[[TCWebserviceStore wsStore] allWebservices] objectAtIndex:[indexPath row]];
    NSLog(@"-->> Selected: %@", ws.title);

    [cell.imageView setImage:[UIImage imageNamed:ws.imagePath]];
    
    [cell.textLabel setText: ws.title];
    [cell.detailTextLabel setText:ws.username];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TCWebservice *selectedWS = [[[TCWebserviceStore wsStore] allWebservices] objectAtIndex:[indexPath row]];
    
    // transition to DetailController
    WebserviceDetailVC *detailVC = [[WebserviceDetailVC alloc] init];
    detailVC.detailItemWebService = selectedWS;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[TCWebserviceStore wsStore] moveItemAtIndex:[fromIndexPath row]toIndex:[toIndexPath row]];
}

- (IBAction)addNewWebservice:(id)sender {
    NewWebserviceVC *newWsVC = [[NewWebserviceVC alloc] init];
    [[self navigationController] pushViewController:newWsVC animated:YES];
//    TCWebserviceEntity *newWS = [[TCWebserviceStore webservices] createNewWebservice];
    
//    // Figure out where that item is in the array
//    int lastRow = [[[TCWebserviceStore webservices] allWebservices] indexOfObject:newWS];
//    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    
//    // insert new row into table
//    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip ] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TCWebserviceStore *wsStore = [TCWebserviceStore wsStore];
        NSArray *wsList = [wsStore allWebservices];
        TCWebservice *ws = [wsList objectAtIndex:[indexPath row]];
        [wsStore removeWebservice:ws];
        
        // We also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
