//
//  TaskDetailVC.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TaskDetailVC.h"
#import "UIColor+TimeChickenAdditions.h"
#import "UIButton+TimeChickenAdditions.h"
#import "TCTask.h"
#import "TaskDetailEditCell.h"
#import "TCDatePicker.h"
#import "TCTaskStore.h"
#import "TimeSessionCell.h"
#import "TCTimeSession.h"
#import "TimeSessionListVC.h"


@interface TaskDetailVC ()<UITextFieldDelegate>
@property (nonatomic,strong) TCDatePicker* datepicker;

@end

@implementation TaskDetailVC

@synthesize detailItem = _detailItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor tcMetallicColor];
    
    self.title = @"TaskDetails";
    
    //Load the NIB-File for Custom Task-TableCell
    UINib *nibTaskDetailEditCell = [UINib nibWithNibName:@"TaskDetailEditCell" bundle:nil];
    
    //Register this NIB which contains the cell
    [[self tableView] registerNib:nibTaskDetailEditCell forCellReuseIdentifier:@"TaskDetailEditCell"];
    
    UIButton *timerButton = [UIButton tcOrangeButton];
    [timerButton setFrame:CGRectMake(10.0, 270.0, 300.0, 42.0)];
    [timerButton addTarget:self action:@selector(timerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [timerButton setTitle:@"Start Time Tracker" forState:UIControlStateNormal];
    
    [self.view addSubview:timerButton];

    if ([self.detailItem isCompleted]) {
        UIButton *reopenButton = [UIButton tcBlackButton];
        [reopenButton setFrame:CGRectMake(10.0, 330.0, 300.0, 42.0)];
        [reopenButton addTarget:self action:@selector(closeTaskButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [reopenButton setTitle:@"Reopen" forState:UIControlStateNormal];
        
        [self.view addSubview:reopenButton];
    } else {
        UIButton *completeButton = [UIButton tcBlackButton];
        [completeButton setFrame:CGRectMake(10.0, 330.0, 300.0, 42.0)];
        [completeButton addTarget:self action:@selector(closeTaskButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [completeButton setTitle:@"Complete" forState:UIControlStateNormal];
        
        [self.view addSubview:completeButton];
    }

    
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
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    // Cells for atributes
    if (indexPath.section==0) {
        TaskDetailEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskDetailEditCell"];
        [cell.keyLabel setFont:[UIFont systemFontOfSize:14.f]];
        [cell.keyLabel setFrame:CGRectMake(10.0, 15.0, 100.0, 15.0)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch(indexPath.row)
        {
            case 0:{
                [[cell keyLabel] setText:@"Title:"];
                [[cell valueTextfield] setText:self.detailItem.title];
                [[cell valueTextfield] addTarget:self action:@selector(titleFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                break;
            }
            case 1:{
                [[cell keyLabel] setText:@"Project:"];
                [[cell valueTextfield] setText:self.detailItem.project];
                [[cell valueTextfield] addTarget:self action:@selector(projectFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                break;
            }
            case 2:{
                [[cell keyLabel] setText:@"Description:"];
                [[cell valueTextfield] setText:self.detailItem.desc];
                [[cell valueTextfield] addTarget:self action:@selector(descriptionFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                break;
            }
            case 3:{
                [[cell keyLabel] setText:@"Due Date:"];
                self.datepicker = [[TCDatePicker alloc] initWithDateFormatString:@"DD.MM.YYYY - HH:mm" forTextField:[cell valueTextfield] withDatePickerMode:UIDatePickerModeDateAndTime];
                cell.valueTextfield.inputView = self.datepicker;
                if(self.detailItem.dueDate){
                    self.datepicker.date = self.detailItem.dueDate;
                }
                [self.datepicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
                break;
            }
        }        
        return cell;
    }    
    // Cell for working time
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TaskWorkedTimeCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.f]];
        [cell.textLabel setFrame:CGRectMake(10.0, 15.0, 100.0, 15.0)];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        [cell.textLabel setText:@"Worked Time:"];
        [cell.detailTextLabel setText:[self.detailItem workedTimeAsString]];    

        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1 && indexPath.row == 0) {
        TimeSessionListVC *timeSessionVC = [[TimeSessionListVC alloc] init];
        timeSessionVC.task = self.detailItem;
        [[self navigationController] pushViewController:timeSessionVC animated:YES];
        
    }
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //close keyboard if return is pressed (in textfield)
    [textField resignFirstResponder];
    return YES;
}

- (void)reopenTask {
    [[TCTaskStore taskStore] reopenTask:self.detailItem];
}

- (void)completeTask {
    [[TCTaskStore taskStore] completeTask:self.detailItem];
}

-(IBAction)titleFieldChanged:(UITextField*)sender{
    self.detailItem.title = sender.text;
}

-(IBAction)projectFieldChanged:(UITextField*)sender{
    self.detailItem.project = sender.text;
}

-(IBAction)descriptionFieldChanged:(UITextField*)sender{
    self.detailItem.desc = sender.text;
}

-(IBAction)datePickerDateChanged:(UIDatePicker*)sender{
    self.detailItem.dueDate = [sender date];
}

-(IBAction)closeTaskButtonPressed:(UIButton*)sender{
    [sender setSelected:YES];
    if ([self.detailItem isCompleted]) {
        [self reopenTask];
        [[self tableView] reloadInputViews];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    } else {
        [self completeTask];
        [[self tableView] reloadInputViews];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)timerButtonPressed:(UIButton*)sender {
    NSLog(@"-->> Timer Button pressed!");
}

@end