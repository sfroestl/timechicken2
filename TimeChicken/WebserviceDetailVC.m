//
//  WebserviceDetailVC.m
//  Time Chicken
//
//  Created by Sebastian Fröstl on 21.01.13.
//
//

#import "WebserviceDetailVC.h"

#import "UIColor+TimeChickenAdditions.h"
#import "UIButton+TimeChickenAdditions.h"
#import "ChooseTaskVC.h"
#import "TCTaskStore.h"
#import "TCWebservice.h"
#import "TCWebserviceStore.h"

#import "TCJiraClient.h"
#import "TCOneSparkClient.h"


@implementation WebserviceDetailVC {
@private
    __strong UIActivityIndicatorView *_activityIndicatorView;
}

@synthesize detailItemWebService;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
//        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
        
        // Set this bar button item as the right item in navigation
//        [[self navigationItem] setRightBarButtonItem:editButton];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(detailItemWebService) {
        [self setTitle:detailItemWebService.title];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor tcMetallicColor];        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    if (section == 0) {
        if (self.detailItemWebService.type == ONESPARK) {
            count = 2;
        } else if (self.detailItemWebService.type == JIRA) {
            count = 3;
        }
    }
    else if (section == 1) {
        count = 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *wsCellIdentifier = @"WSCell";
    TCWebservice *ws = self.detailItemWebService;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:wsCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wsCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([indexPath section] == 0) {
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 6, 180, 30)];
            textLabel.adjustsFontSizeToFitWidth = YES;
            textLabel.textColor = [UIColor blackColor];
            textLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            if ([indexPath row] == 0) {
                cell.textLabel.text = @"Title";
                textLabel.text = ws.title;
            } else if([indexPath row] == 1){
                cell.textLabel.text = @"Username";
                textLabel.text = ws.username;
            }
            else if ([indexPath row] == 2){
                cell.textLabel.text = @"URL";
                textLabel.text = ws.baseUrlString;
            }            
            [cell addSubview:textLabel];
        }
    else {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 7, 50, 30)];
        textLabel.textColor = [UIColor blackColor];
        textLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        cell.textLabel.text = @"Importet Tasks";
        int count = [[[TCTaskStore taskStore] findByWsId:ws.wsID] count];
        textLabel.text = [NSString stringWithFormat:@"%i", count];
        [cell addSubview:textLabel];
        }
    }    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    int width = tableView.frame.size.width - 20;
    
    if (section == 1) {
        
        UIButton *importButton = [UIButton tcOrangeButton];
        [importButton addTarget:self action:@selector(fetchTaskButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [importButton setTitle:@"Import Tasks" forState:UIControlStateNormal];
        [importButton setFrame:CGRectMake(10.0, 20.0, width, 42.0)];
        
        [self.view addSubview:importButton];
        
        UIButton *deleteButton = [UIButton tcBlackButton];
        [deleteButton addTarget:self action:@selector(removeWSButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [deleteButton setTitle:@"Remove" forState:UIControlStateNormal];
        [deleteButton setFrame:CGRectMake(10.0, 72.0, width, 42.0)];
        
        [self.view addSubview:deleteButton];
        
        //create a footer view on the bottom of the tabeview
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 280, 100)];
        [footerView addSubview: importButton];
        [footerView addSubview: deleteButton];
        return footerView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 150.0;
    }
    return 0;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.tableView reloadData];
}

# pragma mark Actions
- (IBAction)fetchTaskButtonPressed:(id)sender {
    [self fetchTasks];
}

- (IBAction)editButtonPressed:(id)sender {
    
}

# pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Clicked %i", buttonIndex);
    if(buttonIndex == 1) {
        [self removeWebservice];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
}


- (IBAction)removeWSButtonPressed:(id)sender {
    NSString *message = [NSString stringWithFormat:@"Remove %@?", self.detailItemWebService.title];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:@"This will also delete imported tasks!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
}


# pragma mark Private
- (void)fetchTasks {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fetching data..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    [indicator startAnimating];
    [alert addSubview:indicator];
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSLog(@"-->> fetchTasks");
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    TCClient<TCRestClientIF> *client = nil;
    TCWebservice *webService = self.detailItemWebService;
    
    switch (webService.type) {
        case ONESPARK:
            client = [TCOneSparkClient oneSparkClient];
            break;
        case JIRA:
            client = [TCJiraClient jiraClientWithBaseUrl:webService.baseUrlString];
            break;
    }
    if (client) {
        [client setBasicAuthUsername:webService.username andPassword:webService.password];
        
        [client fetchUserTaskList:^(NSArray *tasks, NSError *error) {            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if (error) {
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            } else {
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                ChooseTaskVC *wsResultCtrl = [[ChooseTaskVC alloc] init];
                [wsResultCtrl setWsTasks:tasks];
                [self.navigationController pushViewController:wsResultCtrl animated:YES];
            }
            [_activityIndicatorView stopAnimating];
        } withWebservice:webService];
    }
    
}

- (void) removeWebservice {
    NSLog(@"-->> remove WS!");
    TCWebservice *ws = [self detailItemWebService];
    [[TCTaskStore taskStore] removeTasksOfWsId: ws.wsID];
    [[TCWebserviceStore wsStore] removeWebservice:ws];
}


@end
