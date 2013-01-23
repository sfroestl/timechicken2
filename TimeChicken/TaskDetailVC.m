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
#import "TimeSession.h"

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
    self.tableView.backgroundColor = [UIColor tcMetallicColor];
    
    self.title = @"TaskDetails";
    
    //Load the NIB-File for Custom Task-TableCell
    UINib *nibTaskDetailEditCell = [UINib nibWithNibName:@"TaskDetailEditCell" bundle:nil];
    
    //Register this NIB which contains the cell
    [[self tableView] registerNib:nibTaskDetailEditCell forCellReuseIdentifier:@"TaskDetailEditCell"];
    
    //Load the NIB-file for Custom TimeSession-Cell
    UINib *nibTimeSessionCell = [UINib nibWithNibName:@"TimeSessionCell" bundle:nil];
    
    //Register the NIB which contains the cell
    [[self tableView] registerNib:nibTimeSessionCell forCellReuseIdentifier:@"TimeSessionCell"];
    

    if ([self.detailItem isCompleted]) {
        UIButton *reopenButton = [UIButton tcBlackButton];
        [reopenButton setFrame:CGRectMake(10.0, 250.0, 300.0, 42.0)];
        [reopenButton addTarget:self action:@selector(closeTaskButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [reopenButton setTitle:@"Reopen" forState:UIControlStateNormal];
        
        [self.view addSubview:reopenButton];
    } else {
        UIButton *completeButton = [UIButton tcOrangeButton];
        [completeButton setFrame:CGRectMake(10.0, 250.0, 300.0, 42.0)];
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
    int count;
    switch(section)
    {
        case 0: count = 5; break;  //Task-properties
        case 1: count = [self.detailItem.timeSessions count]; break;    //TimeSessionlist
    }
    
    return count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    int count;
    if (section == 1){
        count = 100;
    } else {
        count = 10;
    }
    return count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *customTitleView;
    
    if (section == 1){
        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
        UILabel *titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        titleLabel.text = @"Your Tracked Time";
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.shadowColor = [UIColor whiteColor];
        titleLabel.shadowOffset = CGSizeMake(0.75, 1.0);
        titleLabel.backgroundColor = [UIColor clearColor];
        [customTitleView addSubview:titleLabel];
    }
    return customTitleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskDetailEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskDetailEditCell"];
    if (indexPath.section==0) {      
        
        switch(indexPath.row)
        {
            case 0:{
                [[cell keyLabel] setText:@"Title"];
                [[cell valueTextfield] setText:self.detailItem.title];
                [[cell valueTextfield] addTarget:self action:@selector(titleFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
            case 1:{
                [[cell keyLabel] setText:@"Project"];
                [[cell valueTextfield] setText:self.detailItem.project];
                [[cell valueTextfield] addTarget:self action:@selector(projectFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
            case 2:{
                [[cell keyLabel] setText:@"Description"];
                [[cell valueTextfield] setText:self.detailItem.desc];
                [[cell valueTextfield] addTarget:self action:@selector(descriptionFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
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
                break;
            }
            case 4:{
                [[cell keyLabel] setText:@"Worked Time"];
                [[cell valueTextfield] setText:[NSString stringWithFormat:@"%d", self.detailItem.workedTime]];
                [[cell valueTextfield] addTarget:self action:@selector(workedTimeFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                cell.valueTextfield.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    //TimeSessions
    if(indexPath.section == 2){
        TimeSessionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeSessionCell"];
        TimeSession *ts = [self.detailItem.timeSessions objectAtIndex:indexPath.row];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YY.MM.dd HH:mm"];
        [[cell startDate] setText:[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:[ts start]]]];
        [[cell endDate] setText:[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:[ts end]]]];
        [[cell duration] setText:[NSString stringWithFormat:@"%@", [ts getDurationAsString]]];
    }
    return cell;
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
        [[self tableView] reloadInputViews];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    } else {
        [self completeTask];
        [[self tableView] reloadInputViews];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
}

@end