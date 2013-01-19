//
//  WebserviceDetailViewController.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "WebserviceDetailVC.h"
#import "ChooseTaskVC.h"
#import "TCWebserviceEntity.h"
#import "TCWSOneSpark.h"
#import "TCRestClient.h"
#import "OneSparkRestClient.h"
#import "TCTaskStore.h"

@interface WebserviceDetailVC ()

@end

@implementation WebserviceDetailVC

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
            restClient = [[OneSparkRestClient alloc] initRestClientwithDelegate:self];
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
    NSLog(@"%@", restClient);
    [restClient fetchUserTaskList];
}

- (IBAction)fetchTaskButtonPressed:(id)sender {    
    [self fetchTasks];
}

- (void) resetClientFinished:(TCRestClient*)client{
    NSLog(@"--> RestClientDelegate called with FINISHED");
    NSMutableArray *fetchedTasks = [[NSMutableArray alloc] init];
    
    NSDictionary *jsonData = [client jsonResponse];
    for (NSMutableArray *taskJson in [jsonData valueForKey:@"tasks"]) {
//        NSLog(@"Task: %@", taskJson);
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        NSString *due_date_string = [taskJson valueForKey:@"due_date"];
//        if (due_date_string) {
//            NSDate *dueDate = [dateFormat dateFromString:[taskJson valueForKey:@"due_date"]];
//        }
        
       
        NSLog(@"Due Date: %@", [taskJson valueForKey: @"due_date"]);
        bool completed = [[taskJson valueForKey:@"completed"] boolValue];
        
        TCTask *task = [[TCTask alloc] initWithTitle:[taskJson valueForKey:@"title"]
                                                 desc:[taskJson valueForKey:@"desc"]
                                              project:nil
                                              dueDate:nil
                                                  url:[NSString stringWithFormat:@"http://api.onespark.de/api/v1/tasks/%@", [taskJson valueForKey:@"id"]]
                                            completed:completed
                                               wsType: ONESPARK];
        task.wsId = [[taskJson valueForKey:@"id"] integerValue];
        if ([self.detailItem isKindOfClass: [TCWSOneSpark class]]) {
            task.wsType = 1;
        }
        [fetchedTasks addObject:task];
    }
        
    ChooseTaskVC *wsResultCtrl = [[ChooseTaskVC alloc] init];
    [wsResultCtrl setWsTasks:fetchedTasks];
    [self.navigationController pushViewController:wsResultCtrl animated:YES];
    
}
- (void) restClient:(TCRestClient*)restClient failedWithError:(NSError*)error{
    NSLog(@"RestClient ERROR: %@", error);
}
@end
