//
//  TaskDetailVC.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TaskDetailVC.h"
#import "TCTask.h"
#import "TaskDetailEditCell.h"
#import "TCDatePicker.h"
#import "TCTaskStore.h"
#import "ButtonCell.h"

@interface TaskDetailVC ()<UITextFieldDelegate>
@property (nonatomic,strong) TCDatePicker* datepicker;

@end

@implementation TaskDetailVC

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
    self.tableView.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
    
    self.title = @"TaskDetails";
    
    //Load the NIB-File for Custom Task-TableCell
    UINib *nibTaskDetailEditCell = [UINib nibWithNibName:@"TaskDetailEditCell" bundle:nil];
    
    //Register this NIB which contains the cell
    [[self tableView] registerNib:nibTaskDetailEditCell forCellReuseIdentifier:@"TaskDetailEditCell"];
    
    //Load the NIB-file for Custom Button-Cell
    UINib *nibButtonCell = [UINib nibWithNibName:@"ButtonCell" bundle:nil];
    
    //Register the NIB which contains the cell
    [[self tableView] registerNib:nibButtonCell forCellReuseIdentifier:@"ButtonCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0: return 5;   //Task-properties
        case 1: return 1;   //Complete-Button
        case 2: return [self.detailItem.timeSessions count];    //TimeSessionlist
    }
    
    return -1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section)
    {
        case 0: return nil;
        case 1: return nil;
        case 2: return @"Time Sessions";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        TaskDetailEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskDetailEditCell"];
        
        switch(indexPath.row)
        {
            case 0:{
                [[cell keyLabel] setText:@"Title"];
                [[cell valueTextfield] setText:self.detailItem.title];
                [[cell valueTextfield] addTarget:self action:@selector(titleFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            case 1:{
                [[cell keyLabel] setText:@"Project"];
                [[cell valueTextfield] setText:self.detailItem.project];
                [[cell valueTextfield] addTarget:self action:@selector(projectFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            case 2:{
                [[cell keyLabel] setText:@"Description"];
                [[cell valueTextfield] setText:self.detailItem.desc];
                [[cell valueTextfield] addTarget:self action:@selector(descriptionFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            case 3:{
                [[cell keyLabel] setText:@"Due Date"];
                self.datepicker = [[TCDatePicker alloc] initWithDateFormatString:@"YYYY-MM-DD HH:mm" forTextField:[cell valueTextfield] withDatePickerMode:UIDatePickerModeDateAndTime];
                cell.valueTextfield.inputView = self.datepicker;
                if(self.detailItem.dueDate){
                    self.datepicker.date = self.detailItem.dueDate;
                }
                [self.datepicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            case 4:{
                [[cell keyLabel] setText:@"worked Time"];
                [[cell valueTextfield] setText:[NSString stringWithFormat:@"%d", self.detailItem.workedTime]];
                [[cell valueTextfield] addTarget:self action:@selector(workedTimeFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        
    }
    
    if(indexPath.section == 1){
        
        //Complete Button
        ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
        if ([self.detailItem isCompleted]) {
            [[cell button] addTarget:self action:@selector(closeTaskButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [[cell button] setTitle:@"reopen" forState:UIControlStateNormal];
        } else {
            [[cell button] addTarget:self action:@selector(closeTaskButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [[cell button] setTitle:@"complete" forState:UIControlStateNormal];
        }            
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];

        return cell;
    }
    
    if(indexPath.section == 2){
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = @"bla";
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
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

-(IBAction)workedTimeFieldChanged:(UITextField*)sender{
    self.detailItem.workedTime = [sender.text intValue];
}

-(IBAction)closeTaskButtonPressed:(UIButton*)sender{
    [sender setSelected:YES];
    if ([self.detailItem isCompleted]) {
        [self reopenTask];
        [[self tableView] reloadData];
    } else {
        [self completeTask];
        [[self tableView] reloadData];
        [[self navigationController] popToRootViewControllerAnimated:NO];
    }
}

@end