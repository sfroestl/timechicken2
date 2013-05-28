//
//  TimeSessionDetailVC.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 28.05.13.
//
//

#import "TCTimeSession.h"
#import "TimeSessionDetailVC.h"
#import "UIColor+TimeChickenAdditions.h"
#import "TaskDetailEditCell.h"
#import "TCDatePicker.h"
#import "TCTask.h"

@interface TimeSessionDetailVC ()
@property (nonatomic,strong) TCDatePicker* startDatePicker;
@property (nonatomic,strong) TCDatePicker* endDatePicker;
@end

@implementation TimeSessionDetailVC
@synthesize isNewTimeSession = _isNewTimeSession;
@synthesize task = _task;
@synthesize timeSession = _timeSession;


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
    self.title = @"Time Session";
    //Load the NIB-File for Custom Task-TableCell
    UINib *nibTaskDetailEditCell = [UINib nibWithNibName:@"TaskDetailEditCell" bundle:nil];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveTimeSession:)];
    [[self navigationItem] setRightBarButtonItem:saveButton];
    
    //Register this NIB which contains the cell
    [[self tableView] registerNib:nibTaskDetailEditCell forCellReuseIdentifier:@"TaskDetailEditCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskDetailEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskDetailEditCell"];
    [cell.keyLabel setFont:[UIFont systemFontOfSize:14.f]];
    [cell.keyLabel setFrame:CGRectMake(10.0, 15.0, 100.0, 15.0)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[cell valueTextfield] setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E, dd.MM.YY - HH:mm"];
    
    // Configure the cell
    switch(indexPath.row)
    {
        case 0:{
            [[cell keyLabel] setText:@"Start:"];            
            self.startDatePicker = [[TCDatePicker alloc] initWithDateFormatString:@"E, dd.MM.YYYY - HH:mm" forTextField:[cell valueTextfield] withDatePickerMode:UIDatePickerModeDateAndTime];
            if(self.timeSession.start){
                self.startDatePicker.date = self.timeSession.start;
            }
            cell.valueTextfield.inputView = self.startDatePicker;
            [cell.valueTextfield setFont:[UIFont systemFontOfSize:14.f]];
            [self.startDatePicker addTarget:self action:@selector(datePickerStartDateChanged:) forControlEvents:UIControlEventValueChanged];
            break;
        }
        case 1:{
            [[cell keyLabel] setText:@"End:"];
            self.endDatePicker = [[TCDatePicker alloc] initWithDateFormatString:@"E, dd.MM.YYYY - HH:mm" forTextField:[cell valueTextfield] withDatePickerMode:UIDatePickerModeDateAndTime];
            if(self.timeSession.end){
                self.endDatePicker.date = self.timeSession.end;
            }
            [cell.valueTextfield setFont:[UIFont systemFontOfSize:14.f]];
            cell.valueTextfield.inputView = self.endDatePicker;
            [self.endDatePicker addTarget:self action:@selector(datePickerEndDateChanged:) forControlEvents:UIControlEventValueChanged];
            break;
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

# pragma mark Actions

-(IBAction)datePickerStartDateChanged:(UIDatePicker*)sender{
     NSLog(@"%f > %f", [sender.date timeIntervalSince1970], [self.timeSession.end timeIntervalSince1970]);  
    if(self.timeSession.end != nil && [sender.date timeIntervalSince1970] > [self.timeSession.end timeIntervalSince1970]) {
        NSLog(@"--> return");
        return;
    } else {
        NSLog(@"--> set");
        self.timeSession.start = [sender date];
    }
    
}

-(IBAction)datePickerEndDateChanged:(UIDatePicker*)sender{
     NSLog(@"%f < %f", [sender.date timeIntervalSince1970], [self.timeSession.start timeIntervalSince1970]);
    if([sender.date timeIntervalSince1970] > [self.timeSession.start timeIntervalSince1970]) {
        self.timeSession.end = [sender date];
    }
}

-(IBAction)saveTimeSession:(id)sender {
    NSLog(@"%@, %@", self.timeSession.start, self.timeSession.end);    
    
    if(self.timeSession.start!=NULL && self.timeSession.end!=NULL) {
        if(self.isNewTimeSession) {
            [self.task.timeSessions addObject:self.timeSession];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
