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
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            } else {
                ChooseTaskVC *wsResultCtrl = [[ChooseTaskVC alloc] init];
                [wsResultCtrl setWsTasks:tasks];
                [self.navigationController pushViewController:wsResultCtrl animated:YES];
            }
            [_activityIndicatorView stopAnimating];
        } withWebservice:webService];
    }

}


@end
