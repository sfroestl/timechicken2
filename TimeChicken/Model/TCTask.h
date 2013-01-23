//
//  TCTask.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 13.11.12.
//  Copyright (c) 2012 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TimeSession;

@interface TCTask : NSObject <NSCoding> {
    int _workedTime;
}

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSDate *lastUpdate;
@property (strong, nonatomic) NSString *project;

@property (assign, nonatomic) BOOL completed;
@property (strong, nonatomic) NSMutableArray *timeSessions;
@property (strong, nonatomic) NSDate *completedAt;

@property (strong, nonatomic) NSString *wsProjectId;
@property (assign, nonatomic) int wsType;
@property (assign, nonatomic) int wsID;

- (id)initWithOneSparkAttributes:(NSDictionary *)attributes wsType:(int)wsType wsID:(int)wsId;
- (id)initWithJiraAttributes:(NSDictionary *)attributes wsType:(int)wsType wsID:(int)wsId;
- (id)initWithTitle:(NSString*)title desc:(NSString*)desc projectTitle:(NSString*)project dueDate:(NSDate*)date;
- (id)initWithTitle:(NSString *)title;
- (int) workedTime;

- (int) calculateWorkedTimeInSeconds;

- (NSString*) workedTimeAsString;
- (BOOL) isCompleted;
- (BOOL) isWorking;

@end
