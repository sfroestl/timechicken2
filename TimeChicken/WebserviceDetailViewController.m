//
//  WebserviceDetailViewController.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WebserviceDetailViewController.h"
#import "TCWebservice.h"
#import "TCWSOneSpark.h"
#import "TCRestClient.h"

@interface WebserviceDetailViewController ()

@end

@implementation WebserviceDetailViewController

@synthesize detailItem;

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
    
    if(detailItem) {
        NSLog(@"Selected: %@", self.detailItem.title);
        if ([self.detailItem isKindOfClass: [TCWSOneSpark class]]) {
            NSLog(@"init TCOneSparkRestClient");
            restClient = [[TCRestClient alloc] initOneSparkRestClient];
        }
        [titleField setText:detailItem.title];        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    // Save changes
    [detailItem setTitle: [titleField text]];
}


- (void)fetchTasks {    
    NSLog(@"%@",restClient);
    [restClient getUserTaskList];
}

- (IBAction)fetchTaskButtonPressed:(id)sender {
    [self fetchTasks];
}
@end
