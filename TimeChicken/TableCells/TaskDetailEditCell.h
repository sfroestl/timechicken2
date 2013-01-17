//
//  TaskDetailEditCell.h
//  TimeChicken
//
//  Created by Christian Schäfer on 17.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskDetailEditCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextfield;

@end
