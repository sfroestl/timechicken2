//
//  ButtonCell.h
//  TimeChicken
//
//  Created by Christian Schäfer on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) id controller;
@property (weak, nonatomic) UITableView *tableView;

//- (IBAction)pushButton:(id)sender;

@end
