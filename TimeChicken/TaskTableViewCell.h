//
//  TaskTableViewCell.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 22.01.13.
//
//

#import <UIKit/UIKit.h>
@class TCTask;

@interface TaskTableViewCell : UITableViewCell

@property (nonatomic, strong) TCTask *task;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *dueDateLabel;
@property (nonatomic, strong, readonly) UIButton *timerButton;
@property (nonatomic, strong, readonly) UIImage *webserviceImage;

@end
