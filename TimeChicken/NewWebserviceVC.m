//
//  NewWebserviceVC.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "NewWebserviceVC.h"
#import "TCWebserviceStore.h"
#import "TCWebservice.h"
#import "WebserviceEditVC.h"

@interface NewWebserviceVC ()

@end

@implementation NewWebserviceVC

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [self setTitle: @"Choose a Webservice"];    
        
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    // Set this bar button item as the right item in navigation
    [[self navigationItem] setLeftBarButtonItem:bbi];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [[[TCWebserviceStore wsStore] wsNames] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WSCell"];
    }
    [[cell textLabel] setText:[[[TCWebserviceStore wsStore] wsNames] objectAtIndex:indexPath.row]];
    [[cell detailTextLabel] setText:[[TCWebserviceStore wsStore] wsDescriptionOfType:indexPath.row]];
    [[cell imageView] setImage:[UIImage imageNamed:[[TCWebserviceStore wsStore] wsImageOfType:indexPath.row]]];
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebserviceEditVC *wsDetailVC = [[WebserviceEditVC alloc] init];
    NSLog(@"--> Create WS With type %i", indexPath.row);
    TCWebservice *webservice = [[TCWebserviceStore wsStore] webserviceWithType:indexPath.row];
    NSLog(@"--> WSType is %i", webservice.type);
    wsDetailVC.detailItem = webservice;
    [[self navigationController] pushViewController:wsDetailVC animated:YES];
}
         
- (void)cancel {
    NSLog(@"--> cancel");
//    [self dismissViewControllerAnimated:YES completion:nil];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}


@end
