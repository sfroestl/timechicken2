//
//  TaskTableViewCell.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 22.01.13.
//
//

#import "TaskTableViewCell.h"
#import "UIColor+TimeChickenAdditions.h"
#import "TCTask.h"

@implementation TaskTableViewCell

@synthesize task = _task;
@synthesize webserviceImage = _webserviceImage;
@synthesize timerButton = _timerButton;
@synthesize titleLabel = _titleLabel;
@synthesize dueDateLabel = _dueDateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _titleLabel = [UILabel alloc] initWithFrame:<#(CGRect)#>
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTask:(TCTask *)task {
	_task = task;
	
	if (_task.dueDate != nil) {
		_dueDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(48.0f, 4.0f, 125.0f, 20.0f)];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd.MM.YYYY"];
        [_dueDateLabel setText:[NSString stringWithFormat:@"due: %@", [dateFormat stringFromDate:[_task dueDate]]]];
        _dueDateLabel.textColor = [UIColor tcDueDateColor];
	} 
}

- (void) getCell {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCell"];
//    TCTask *currentTask;
//    if(indexPath.section==0){
//        NSArray *openTasks = [[TCTaskStore taskStore] getOpenTasks];
//        currentTask = [openTasks objectAtIndex:indexPath.row];
//    } else {
//        NSArray *completedTasks = [[TCTaskStore taskStore] getCompletedTasks];
//        currentTask = [completedTasks objectAtIndex:indexPath.row];
//    }
//    
//    
//    cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    UILabel *label;
//    NSLog(@"--> WS ID: %i", currentTask.wsID );
//    if (currentTask.wsType != 0) {
//        label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0.5, 160.0, 25.0)];
//        
//        UIImage *image = [UIImage imageNamed:[[TCWebserviceStore wsStore] wsImageOfType:(currentTask.wsType +1)]];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        //        [imageView setBackgroundColor:[UIColor colorWithPatternImage:image]];
//        [cell.contentView addSubview:imageView];
//        
//    } else {
//        label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0.5, 160.0, 25.0)];
//    }
//    label.font = [UIFont systemFontOfSize:16.0f];
//    [label setTextAlignment:NSTextAlignmentLeft];
//    label.textColor = [UIColor blackColor];
//    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
//    label.backgroundColor = [UIColor whiteColor];
//    label.text = currentTask.title;
//    [cell.contentView addSubview:label];
//    return cell;

}
@end
