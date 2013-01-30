//
//  WebserviceEditVC.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WebserviceEditVC.h"
#import "UIColor+TimeChickenAdditions.h"
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

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
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
        case 1:
            count = 3;
            break;
        case 2:
            count = 4;
            break;
    }
    return count;
}


#pragma mark - Table View delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int width = self.tableView.frame.size.width - 140;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([indexPath section] == 0) {
        UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, width, 30)];
        txtField.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        txtField.tag = 121;
        txtField.adjustsFontSizeToFitWidth = YES;
        txtField.textColor = [UIColor blackColor];
        txtField.backgroundColor = [UIColor groupTableViewBackgroundColor];
        if ([indexPath row] == 0) {
            txtField.text = self.detailItem.title;
            txtField.placeholder = self.detailItem.title;
            txtField.keyboardType = UIKeyboardTypeDefault;
        } else if([indexPath row] == 1){
            txtField.tag = 122;
            txtField.placeholder = @"your username";
            txtField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        else if ([indexPath row] == 2){
            txtField.tag = 123;
            txtField.placeholder = @"your password";
            txtField.keyboardType = UIKeyboardTypeDefault;
            txtField.secureTextEntry = YES;
        }
        else if ([indexPath row] == 3){
            txtField.tag = 124;
            txtField.placeholder = @"http://jira.myserver.de";
            txtField.keyboardType = UIKeyboardTypeURL;
        }
        
        
        txtField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
        txtField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support;
        
        txtField.clearButtonMode = UITextFieldViewModeWhileEditing; 
        [txtField setEnabled: YES];
        
        [cell addSubview:txtField];
    }
    if ([indexPath section] == 0) {
        switch ([indexPath row]) {
            case 0:
                cell.textLabel.text = @"Title";
                break;
            case 1:
                cell.textLabel.text = @"Username";
                break;
            case 2:
                cell.textLabel.text = @"Password";
                break;
            case 3:
                cell.textLabel.text = @"URL";
            default:
                break;
        }
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 220.0f;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.tableView reloadData];
    [self.tableView reloadInputViews];
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *customFooterView = [[UIView alloc] init];
    int width = self.tableView.frame.size.width - 20;
    NSString *desc = [[TCWebserviceStore wsStore] wsDescriptionOfType: self.detailItem.type];
    customFooterView = [ [UIView alloc] initWithFrame:CGRectMake(20, 10, width, 150)];
    UILabel *titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(20, 10, width, 150)];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    titleLabel.text = desc;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0.75, 1.0);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    [customFooterView addSubview:titleLabel];
    
    return customFooterView;
}

#pragma mark - Private

- (void) proveWs {
     
    [_activityIndicatorView startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSLog(@"--> Prove WS");
    
    UITextField *txtField = (UITextField *)[[self view ]viewWithTag:121];
    NSString *title = [txtField text];
    
    txtField = (UITextField *)[[self view ]viewWithTag:122];
    NSString *username = [txtField text];
    
    txtField = (UITextField *)[[self view] viewWithTag:123];
    NSString *password = [txtField text];
    
    TCClient<TCRestClientIF> *client = nil;
    
    if ((password == nil) || (username == nil)) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Please fill in username and password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil, nil] show ];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return;
    }
    
    switch (self.detailItem.type) {
        case ONESPARK:
            client = [TCOneSparkClient oneSparkClient];
            break;
        case JIRA:
            txtField = (UITextField *)[[self view] viewWithTag:124];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connecting..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        [alert show];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        // Adjust the indicator so it is up a few pixels from the bottom of the alert
        indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
        [indicator startAnimating];
        [alert addSubview:indicator];
        
        [client setBasicAuthUsername:username andPassword:password];
        [client fetchUsername:^(NSString *username, NSError *error) {
            if (error) {
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                NSLog(@"--> Connection error %@", error);
                if (error.code == 401) {
                    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection failed", nil) message:@"Your login information is not correct" delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
                } else {
                    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
                }
                self.navigationItem.rightBarButtonItem.enabled = YES;
            } else {
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                if (title != nil) {
                    self.detailItem.title = title;
                }
                self.detailItem.username = username;
                self.detailItem.password = password;
                [self saveWs];
            }
            [_activityIndicatorView stopAnimating];            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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



@end
