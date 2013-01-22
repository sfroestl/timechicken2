//
//  TaskCell.h
//  TimeChicken
//
//  Created by Christian Schäfer on 16.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) id controller;
@property (weak, nonatomic) UITableView *tableView;



@end
