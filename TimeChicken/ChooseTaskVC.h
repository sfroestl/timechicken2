//
//  WSTaskChooseVCViewController.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseTaskVC : UITableViewController {
    NSArray *wsTasks;
}
@property (nonatomic, strong) NSMutableArray *chosedTasksForImport;
@property (nonatomic, strong) NSArray *alreadyImportedTasks;

- (IBAction)importWSTasks:(id)sender;
- (void) setWsTasks:(NSArray *)tasks;

@end
