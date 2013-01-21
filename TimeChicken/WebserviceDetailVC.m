//
//  WebserviceDetailViewController.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WebserviceDetailVC.h"

#import "ChooseTaskVC.h"
#import "TCWebservice.h"
#import "TCTaskStore.h"

#import "TCClient.h"
#import "TCRestClientIF.h"
#import "TCOneSparkClient.h"
#import "TCJiraClient.h"

@interface WebserviceDetailVC ()

@end

@implementation WebserviceDetailVC{
@private
    __strong UIActivityIndicatorView *_activityIndicatorView;
}

@synthesize detailItemWebService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(detailItemWebService) {
        NSLog(@"Selected: %@", self.detailItemWebService);
        [titleField setText:detailItemWebService.title];        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    // Save changes
    [detailItemWebService setTitle: [titleField text]];
}


- (IBAction)fetchTaskButtonPressed:(id)sender {    
    [self fetchTasks];
}


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


@end
