//
//  WebserviceDetailVC.m
//  Time Chicken
//
//  Created by Sebastian Fröstl on 21.01.13.
//
//

#import "WebserviceDetailVC.h"

#import "UIColor+TimeChickenAdditions.h"
#import "ChooseTaskVC.h"
#import "TCTaskStore.h"
#import "TCWebservice.h"

#import "TCJiraClient.h"
#import "TCOneSparkClient.h"

@interface WebserviceDetailVC ()

@end

@implementation WebserviceDetailVC{
@private
    __strong UIActivityIndicatorView *_activityIndicatorView;
}

@synthesize detailItemWebService;

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(detailItemWebService) {
        NSLog(@"Selected: %@", self.detailItemWebService);
        [self setTitle:detailItemWebService.title];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor tcMetallicColor];    
    
    
    UIButton *importButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [importButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [importButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [importButton addTarget:self action:@selector(fetchTaskButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [importButton setTitle:@"Import Tasks" forState:UIControlStateNormal];
    [importButton setFrame:CGRectMake(10.0, 250.0, 300.0, 42.0)];
    
    [self.view addSubview:importButton];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonImage = [[UIImage imageNamed:@"blackButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    buttonImageHighlight = [[UIImage imageNamed:@"blackButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [deleteButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [deleteButton addTarget:self action:@selector(deleteWebservice) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"Delete Webservice" forState:UIControlStateNormal];
    [deleteButton setFrame:CGRectMake(10.0, 310.0, 300.0, 42.0)];
    
    [self.view addSubview:deleteButton];
    
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
    int count;
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
    TCWebservice *displayedWs = self.detailItemWebService;
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
                textLabel.text = displayedWs.title;
            } else if([indexPath row] == 1){
                cell.textLabel.text = @"Username";
                textLabel.text = displayedWs.username;
            }
            else if ([indexPath row] == 2){
                cell.textLabel.text = @"URL";
                textLabel.text = displayedWs.baseUrlString;
            }            
            [cell addSubview:textLabel];
        }
    else {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 7, 50, 30)];
        textLabel.textColor = [UIColor blackColor];
        textLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        cell.textLabel.text = @"Importet Tasks";
        int count = [[[TCTaskStore taskStore] findByWsType:displayedWs.type] count];
        textLabel.text = [NSString stringWithFormat:@"%i", count];
        [cell addSubview:textLabel];
        }
    }    
    return cell;
}


# pragma mark Actions
- (IBAction)fetchTaskButtonPressed:(id)sender {
    [self fetchTasks];
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

- (void) deleteWebservice {
    NSLog(@"-->> Delete WS!");
}


@end
