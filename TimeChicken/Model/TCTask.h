//
//  TCTask.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 13.11.12.
//  Copyright (c) 2012 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCTask : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *project;
@property (strong, nonatomic) NSDate *dueDate;
@property (assign, nonatomic) int workedTime;
@property (assign, nonatomic) BOOL completed;

- (id)initWithAttributes:(NSString*)title desc:(NSString*)desc project:(NSString*)project dueDate:(NSDate*)dueDate;
- (id)initWithTitle:(NSString *)title;
@end
