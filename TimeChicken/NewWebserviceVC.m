//
//  NewWebserviceVC.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "NewWebserviceVC.h"
#import "UIColor+TimeChickenAdditions.h"
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
        [self setTitle: @"Collaboration Tool"];
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor tcMetallicColor];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // cause default (lokal) is within array
    return ([[[TCWebserviceStore wsStore] wsNames] count]) -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WSCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundView:nil];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    // default (lokal) is stored in array at pos 0
    [[cell textLabel] setText:[[[TCWebserviceStore wsStore] wsNames] objectAtIndex:(indexPath.row +1)]];
    [[cell detailTextLabel] setText:[[TCWebserviceStore wsStore] wsDescriptionOfType:(indexPath.row +1)]];
    [[cell imageView] setImage:[UIImage imageNamed:[[TCWebserviceStore wsStore] wsImageOfType:(indexPath.row + 1)]]];
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebserviceEditVC *wsDetailVC = [[WebserviceEditVC alloc] init];
    TCWebservice *webservice = nil;
    switch (indexPath.row) {
        case 0:
            NSLog(@"--> Create WS With type %i", ONESPARK);
            webservice = [[TCWebserviceStore wsStore] webserviceWithType:ONESPARK];
            NSLog(@"--> WSType is %i", webservice.type);            
            break;
        case 1:
            NSLog(@"--> Create WS With type %i", JIRA);
            webservice = [[TCWebserviceStore wsStore] webserviceWithType:JIRA];
            NSLog(@"--> WSType is %i", webservice.type);
            break;
    }
    if (webservice) {
        wsDetailVC.detailItem = webservice;
        [[self navigationController] pushViewController:wsDetailVC animated:YES];
    }
   
}


#pragma mark - private

- (void)cancel {
    NSLog(@"--> cancel");
//    [self dismissViewControllerAnimated:YES completion:nil];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}


@end
