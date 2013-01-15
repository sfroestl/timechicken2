//
//  FirstViewController.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TaskListViewController.h"
#import "TCTaskStore.h"
#import "TCTask.h"

@interface TaskListViewController ()

@end

@implementation TaskListViewController

- (id) init{
    //call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        self.title = @"Tasks";
        for (int i=0; i<5; i++){
            [[TCTaskStore taskStore] createNewTask];
        }
    }
    return self;
}

-(id) initWithStyle:(UITableViewStyle)style{
    return [self init];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.title = NSLocalizedString(@"First", @"First");
//        self.tabBarItem.image = [UIImage imageNamed:@"first"];
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

typedef enum { SectionHeader, SectionMiddle, SectionDetail } Sections;

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0: return [[[TCTaskStore taskStore] openTasks] count];
        case 1: return [[[TCTaskStore taskStore] completedTasks] count];
        default: return [[[TCTaskStore taskStore] openTasks] count];
    }
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    // snip
//    switch (indexPath.section) {
//        case SectionHeader:
//            // snip
//            break;
//        case SectionMiddle:
//            // snip
//            break;
//        case SectionDetail:
//            // snip
//            break;
//    }
//}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0: return @"Open Tasks";
        case 1: return @"Completed Tasks";
        default: return @"Tasks";
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //check for reusable cell first, use that if it exists
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    //If there is no reusable cell of this type, create a new one
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    //Set the the text on the cell with the title of the task
    //that is at the nth index of items, where n = row this cell will appear in the tableView
    TCTask * task = [[[TCTaskStore taskStore] openTasks] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[task title]];
    return cell;
}



@end
