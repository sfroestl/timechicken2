//
//  WebserviceEditVC.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WebserviceEditVC.h"
#import "TCWebservice.h"
#import "TCWebserviceStore.h"
#import "TCClient.h"
#import "TCRestClientIF.h"
#import "TCOneSparkClient.h"
#import "TCJiraClient.h"

//#import "TCWSJira.h"

@interface WebserviceEditVC ()

@end

@implementation WebserviceEditVC {
@private
    __strong UIActivityIndicatorView *_activityIndicatorView;
}

@synthesize detailItem = _detailItem;

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
//        UIBarButtonItem *cancelBbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        UIBarButtonItem *saveBbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(proveWs)];
        
//        [[self navigationItem] setLeftBarButtonItem:cancelBbi];
        [[self navigationItem] setRightBarButtonItem:saveBbi];
        if (self.detailItem) {
//            if ([self.detailItem isKindOfClass:[TCWSOneSpark class]]) {
//                restClient = [[OneSparkRestClient alloc] initRestClientwithDelegate:self];
//            }
        }
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Detail item: %@", self.detailItem);
    self.title = self.detailItem.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count;
    switch (self.detailItem.type) {            
        case 0:
            count = 2;
            break;
        case 1:
            count = 3;
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *wsCellIdentifier = @"EditCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:wsCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wsCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([indexPath section] == 0) {
            UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 185, 30)];
            txtField.tag = 121;
            txtField.adjustsFontSizeToFitWidth = YES;
            txtField.textColor = [UIColor blackColor];
            txtField.backgroundColor = [UIColor groupTableViewBackgroundColor];
            if ([indexPath row] == 0) {
                txtField.placeholder = @"your username";
                txtField.keyboardType = UIKeyboardTypeEmailAddress;
            }
            else if ([indexPath row] == 1){
                txtField.tag = 122;
                txtField.placeholder = @"your password";
                txtField.keyboardType = UIKeyboardTypeDefault;
                txtField.secureTextEntry = YES;
            }
            else if ([indexPath row] == 2){
                txtField.tag = 123;
                txtField.placeholder = @"http://jira.myserver.de";
                txtField.keyboardType = UIKeyboardTypeURL;
            }
            
            
            txtField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            txtField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support;
            
            txtField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
            [txtField setEnabled: YES];
            
            [cell addSubview:txtField];
        }
    }
    if ([indexPath section] == 0) {
        switch ([indexPath row]) {
            case 0:
                cell.textLabel.text = @"Username";
                break;
            case 1:
                cell.textLabel.text = @"Password";
                break;
            case 2:
                cell.textLabel.text = @"URL";
            default:
                break;
        }
    }
    else { // Login button section
        cell.textLabel.text = @"Log in";
    }
    return cell;    

}

- (void) proveWs {
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSLog(@"--> Prove WS");
    UITextField *txtField = (UITextField *)[[self view ]viewWithTag:121];
    NSString *username = [txtField text];
    
    txtField = (UITextField *)[[self view] viewWithTag:122];
    NSString *password = [txtField text];
    NSLog(@"--> username %@", username);
    TCClient<TCRestClientIF> *client = nil;
    
    if ((password == nil) || (username == nil)) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Please fill in username and password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil, nil] show ];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return;
    }
    
    switch (self.detailItem.type) {
        case 0:
            client = [TCOneSparkClient oneSparkClient];
            break;
        case 1:
            txtField = (UITextField *)[[self view] viewWithTag:123];
            NSString *url = [txtField text];
            
            if (url == nil) {
                [[[UIAlertView alloc] initWithTitle:nil message:@"Please fill in a valid url" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil, nil] show ];
                self.navigationItem.rightBarButtonItem.enabled = YES;
                return;
            }
            
            client = [TCJiraClient jiraClientWithBaseUrl:url];
            self.detailItem.baseUrlString = url;
            break;
    }
    if (client) {
        [client setBasicAuthUsername:username andPassword:password];
        [client fetchUsername:^(NSString *username, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
                self.navigationItem.rightBarButtonItem.enabled = YES;
            } else {
                self.detailItem.username = username;
                self.detailItem.password = password;
                [self saveWs];
            }
            [_activityIndicatorView stopAnimating];
        }];
    }
}

- (void) saveWs {
    NSLog(@"--> Save WS");
    TCWebservice *ws = self.detailItem;
    
    if ([[TCWebserviceStore wsStore] containsWs:ws]) {
        NSLog(@"-->> Already exists");
        [[[UIAlertView alloc] initWithTitle:@"Did you forget?"
                                    message:[NSString stringWithFormat:@"You're already connected with %@", ws.username]
                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil, nil] show];
        [[self navigationController] popToRootViewControllerAnimated:YES];
        return;
    }
    [[TCWebserviceStore wsStore] addWebservice:ws];
    [[[UIAlertView alloc] initWithTitle:@"Well done!"
                                message:[NSString stringWithFormat:@"You're logged in with %@", ws.username]
                               delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil, nil] show];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}


/*
/ Override to support conditional editing of the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
