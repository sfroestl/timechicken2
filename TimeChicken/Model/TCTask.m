//
//  TCTask.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 13.11.12.
//  Copyright (c) 2012 Sebastian Fröstl. All rights reserved.
//

#import "TCTask.h"
#import "TCOneSparkClient.h"
#import "TCTimeSession.h"

@implementation TCTask

@synthesize title = _title;
@synthesize desc = _desc;
@synthesize project = _project;
@synthesize dueDate = _dueDate;
@synthesize completed = _completed;
@synthesize completedAt = _completedAt;
@synthesize working = _working;

@synthesize timeSessions = _timeSessions;

@synthesize wsType = _wsType;
@synthesize wsID = _wsID;
@synthesize lastUpdate = _lastUpdate;
@synthesize url = _url;
@synthesize wsProjectId = _wsProjectId;

@synthesize timeTrackerStart = _timeTrackerStart;
@synthesize upTimer = _upTimer;


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
        _timeSessions = [[NSMutableArray alloc] init];
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
        _timeSessions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithTitle:(NSString*)title desc:(NSString*)desc projectTitle:(NSString*)project dueDate:(NSDate*)date {
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        self.project = project;
        _timeSessions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    if((self = [super init])){
        self.title = title;
        _timeSessions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (int) workedTime {
    return [self calculateWorkedTimeInSeconds];
}

- (NSString*)workedTimeAsString2{
    int sec = [self calculateWorkedTimeInSeconds];
    int seconds = sec;
    int minutes = 0;
    int hours = 0;
    int days = 0;
    
    if (seconds >= 60)
    {
        minutes = seconds / 60;
        seconds = seconds % 60;
        if (minutes >= 60)
        {
            hours = minutes / 60;
            minutes = minutes % 60;
            if(hours>=24)
            {
                days = hours / 24;
                hours = hours % 24;
            }
        }
    };
    
    if (sec>89999) return [NSString stringWithFormat:@"%d d %d h",days, hours];
    if(sec>86399) return [NSString stringWithFormat:@"%d days",days];
    if(sec>3599) return [NSString stringWithFormat:@"%d h %d min",hours, minutes];
    if(sec>59) return [NSString stringWithFormat:@"%d min",minutes];

    return [NSString stringWithFormat:@"%d sek",sec];
}

- (BOOL) isCompleted {
    return _completed;
}

- (BOOL) isWorking {
    return _working;
}

- (int) calculateWorkedTimeInSeconds {
    int seconds = 0;
    for (TCTimeSession *timeSession in _timeSessions) {
        seconds = seconds + timeSession.durationInSeconds;
    }
    return seconds;
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

# pragma mark Encode to save data

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.dueDate forKey:@"dueDate"];
    [aCoder encodeObject:self.lastUpdate forKey:@"lastUpdate"];
    [aCoder encodeObject:self.project forKey:@"project"];
    [aCoder encodeBool:self.completed forKey:@"completed"];
    [aCoder encodeObject:self.timeSessions forKey:@"timeSessions"];
    [aCoder encodeObject:self.completedAt forKey:@"completedAt"];
    [aCoder encodeObject:self.wsProjectId forKey:@"wsProjectId"];
    [aCoder encodeInt:self.wsType forKey:@"wsType"];
    [aCoder encodeInt:self.wsID forKey:@"wsID"];
    [aCoder encodeBool:self.working forKey:@"working"];
//    [aCoder encodeObject:self.timeTrackerStart forKey:@"timeTrackerStart"];
//    [aCoder encodeObject:self.upTimer forKey:@"upTimer"];
}

# pragma mark Decode to reload data


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setDesc:[aDecoder decodeObjectForKey:@"desc"]];
        [self setUrl:[aDecoder decodeObjectForKey:@"url"]];
        [self setDueDate:[aDecoder decodeObjectForKey:@"dueDate"]];
        [self setLastUpdate:[aDecoder decodeObjectForKey:@"lastUpdate"]];
        [self setProject:[aDecoder decodeObjectForKey:@"project"]];
        [self setCompleted:[aDecoder decodeBoolForKey:@"completed"]];
        [self setTimeSessions:[aDecoder decodeObjectForKey:@"timeSessions"]];
        [self setCompletedAt:[aDecoder decodeObjectForKey:@"completedAt"]];
        [self setWsProjectId:[aDecoder decodeObjectForKey:@"wsProjectId"]];
        [self setWsType:[aDecoder decodeIntForKey:@"wsType"]];
        [self setWsID:[aDecoder decodeIntForKey:@"wsID"]];
        [self setWorking:[aDecoder decodeBoolForKey:@"working"]];
//        [self setTimeTrackerStart:[aDecoder decodeObjectForKey:@"timeTrackerStart"]];
//        [self setUpTimer:[aDecoder decodeObjectForKey:@"upTimer"]];
    }
    return self;
}


@end
