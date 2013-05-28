//
//  TimeSessionDetailVC.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 28.05.13.
//
//

#import <UIKit/UIKit.h>
@class TCTimeSession;
@class TCTask;
@interface TimeSessionDetailVC : UITableViewController

@property TCTimeSession *timeSession;
@property TCTask *task;
@property (nonatomic, assign) BOOL isNewTimeSession;
@end
