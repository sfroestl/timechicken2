//
//  TCTask.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 13.11.12.
//  Copyright (c) 2012 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

enum WS_TYPES {local, onespark, jira};

@interface TCTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *project;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSDate *completedAt;
@property (strong, nonatomic) NSDate *lastUpdate;
@property (assign, nonatomic) int workedTime;
@property (assign, nonatomic) int wsType;
@property (assign, nonatomic) int wsId;
@property (assign, nonatomic) BOOL completed;
@property (strong, nonatomic) NSMutableArray *timeSessions;

- (id)initWithTitle:(NSString*)title desc:(NSString*)desc project:(NSString*)project dueDate:(NSDate*)dueDate url:(NSString*)url completed:(BOOL)completed wsType:(int)wstype;
- (id)initWithTitle:(NSString *)title;
@end
