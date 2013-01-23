//
//  TimeSessionListVC.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 23.01.13.
//
//

#import "TimeSessionListVC.h"
#import "TCTimeSession.h"
#import "TCTask.h"
#import "UIColor+TimeChickenAdditions.h"
#import "TimeSessionCell.h"


@interface TimeSessionListVC ()

@end

@implementation TimeSessionListVC

static NSString *tsCellIdentifier = @"TimeSessionCell";

@synthesize task = _task;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor tcMetallicColor];
    self.title = @"Worked Time";
    //Load the NIB-file for Custom TimeSession-Cell
    UINib *nibTimeSessionCell = [UINib nibWithNibName:tsCellIdentifier bundle:nil];
    
    //Register the NIB which contains the cell
    [[self tableView] registerNib:nibTimeSessionCell forCellReuseIdentifier:tsCellIdentifier];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    //call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.task timeSessions] count];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 40;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeSessionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tsCellIdentifier];
    TCTimeSession *timeSession = [[self.task timeSessions] objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E, DD.MM.YYYY - HH:mm"];
//    [cell.durationLabel setText:[NSString stringWithFormat:@"%@", [timeSession durationAsString]]];
    [cell.durationLabel setText:[timeSession durationAsString2]];
    cell.endDateLabel.text = [dateFormat stringFromDate:timeSession.end];
    cell.startDateLabel.text = [dateFormat stringFromDate:timeSession.start];
    
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {    
//        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
//        UILabel *titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
//        [titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
//        titleLabel.text = @"Your Tracked Time";
//        titleLabel.textColor = [UIColor grayColor];
//        titleLabel.shadowColor = [UIColor whiteColor];
//        titleLabel.shadowOffset = CGSizeMake(0.75, 1.0);
//        titleLabel.backgroundColor = [UIColor clearColor];
//        [customTitleView addSubview:titleLabel];
//    return customTitleView;
//}

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

@end
