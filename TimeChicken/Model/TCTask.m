//
//  TCTask.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 13.11.12.
//  Copyright (c) 2012 Sebastian Fröstl. All rights reserved.
//

#import "TCTask.h"
#import "TCOneSparkClient.h"

@implementation TCTask

@synthesize title = _title;
@synthesize desc = _desc;
@synthesize project = _project;
@synthesize dueDate = _dueDate;
@synthesize workedTime = _workedTime;
@synthesize completed = _completed;
@synthesize completedAt = _completedAt;

@synthesize timeSessions = _timeSessions;

@synthesize wsType = _wsType;
@synthesize wsID = _wsID;
@synthesize lastUpdate = _lastUpdate;
@synthesize url = _url;
@synthesize wsProjectId = _wsProjectId;


- (id)initWithOneSparkAttributes:(NSMutableDictionary *)attributes wsType:(int)wsType wsID:(int)wsId {
    self = [super init];
    if(self){
        _title = [attributes valueForKeyPath:@"title"];
        _url = [NSString stringWithFormat:@"%@%@", kOSAPIBaseURLString, [attributes valueForKeyPath:@"id"]];
        
        if (![[attributes valueForKey:@"desc"] isKindOfClass:[NSNull class]]) {
            _desc = [attributes valueForKeyPath:@"desc"];
        }
        if (![[[attributes valueForKeyPath:@"project"] valueForKeyPath:@"title"] isKindOfClass:[NSNull class]]) {
            _project = [[attributes valueForKeyPath:@"project"] valueForKeyPath:@"title"];
        }
        if (![[[attributes valueForKeyPath:@"project"] valueForKeyPath:@"id"] isKindOfClass:[NSNull class]]) 
            _wsProjectId = [[attributes valueForKeyPath:@"project"] valueForKeyPath:@"id"];
        
        if (![[attributes valueForKey:@"due_date"] isKindOfClass:[NSNull class]]) {
            _dueDate = [TCTask dateFromString:[attributes valueForKey:@"due_date"]];
        }
        
        if (![[attributes valueForKey:@"completed"] isKindOfClass:[NSNull class]]) {
            _completed = [[attributes valueForKey:@"completed"] integerValue];
        }

        if (![[attributes valueForKey:@"completed_at"] isKindOfClass:[NSNull class]]) {
            _completedAt = [TCTask dateFromString:[attributes valueForKeyPath:@"completed_at"]];
        }
        _wsType = wsType;
        _wsID = wsId;
    }
    return self;
}

- (id)initWithJiraAttributes:(NSDictionary *)attributes wsType:(int)wsType wsID:(int)wsId {
    self = [super init];
    if(self){
        
        if (![[attributes valueForKey:@"self"] isKindOfClass:[NSNull class]]) {
            _url = [attributes valueForKeyPath:@"self"];
        }
        
        NSDictionary *nested = [attributes valueForKeyPath:@"fields"];

        _title = [nested valueForKeyPath:@"summary"];
                        
        if (![[nested valueForKey:@"description"] isKindOfClass:[NSNull class]]) {
            _desc = [nested valueForKeyPath:@"description"];
        }
        if (![[[nested valueForKey:@"project" ] valueForKeyPath:@"name" ] isKindOfClass:[NSNull class]]) {
             _project = [[nested valueForKey:@"project" ] valueForKeyPath:@"name" ];
        }
        if (![[[nested valueForKey:@"project" ] valueForKeyPath:@"id" ] isKindOfClass:[NSNull class]]) {
            _wsProjectId = [[nested valueForKey:@"project" ] valueForKeyPath:@"id" ];
        }
        _wsType = wsType;
        _wsID = wsId;
    }
    return self;
}

- (BOOL) isCompleted {
    return _completed;
}

- (id)initWithTitle:(NSString*)title desc:(NSString*)desc projectTitle:(NSString*)project dueDate:(NSDate*)date {
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        self.project = project;
        self.timeSessions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    if((self = [super init])){
        self.title = title;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{Task: {title:%@, wsType:%i, wsId:%i, completed: %@, desc: %@}}", self.title, self.wsType, self.wsID, self.completed ? @"YES":@"NO", self.desc];
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}


@end
