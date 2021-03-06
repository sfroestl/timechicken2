//
//  TaskDetailVC.h
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCTask;
@interface TaskDetailVC : UITableViewController{
    NSMutableArray *taskDetailsArray;
}

@property (strong, nonatomic) TCTask *detailItem;

- (void) completeTask;
- (void) reopenTask;
@end
