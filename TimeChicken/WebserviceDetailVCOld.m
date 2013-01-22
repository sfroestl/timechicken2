//
//  WebserviceDetailViewController.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WebserviceDetailVCOld.h"

#import "ChooseTaskVC.h"
#import "TCWebservice.h"
#import "TCTaskStore.h"

#import "TCClient.h"
#import "TCRestClientIF.h"
#import "TCOneSparkClient.h"
#import "TCJiraClient.h"

@interface WebserviceDetailVCOld ()

@end

@implementation WebserviceDetailVCOld{
@private
    __strong UIActivityIndicatorView *_activityIndicatorView;
}

@synthesize detailItemWebService;

- (id) init {
    self = [super init];
    if (self) {
        // creating custom button properties
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





@end
