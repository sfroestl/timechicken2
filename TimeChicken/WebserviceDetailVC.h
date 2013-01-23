//
//  WebserviceDetailVC.h
//  Time Chicken
//
//  Created by Sebastian Fröstl on 21.01.13.
//
//

#import <UIKit/UIKit.h>

@class TCOneSparkClient;
@class TCJiraClient;
@class TCWebservice;


@interface WebserviceDetailVC : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) TCWebservice *detailItemWebService;

- (void) fetchTasks;
- (void) removeWebservice;
@end
