//
//  TimeSessionCell.h
//  TimeChicken
//
//  Created by Christian Schäfer on 21.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeSessionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end
