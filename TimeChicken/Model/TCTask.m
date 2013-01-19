//
//  TCTask.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 13.11.12.
//  Copyright (c) 2012 Sebastian Fröstl. All rights reserved.
//

#import "TCTask.h"

@implementation TCTask

@synthesize title = _title;
@synthesize desc = _desc;
@synthesize project = _project;
@synthesize dueDate = _dueDate;
@synthesize workedTime = _workedTime;
@synthesize completed = _completed;
@synthesize wsType = _wsType;
@synthesize wsId = _wsId;
@synthesize lastUpdate = _lastUpdate;

-(id)initWithTitle:(NSString *)title desc:(NSString *)desc project:(NSString *)project dueDate:(NSDate *)dueDate url:(NSString *)url completed:(BOOL)completed wsType:(int)wstype{
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        self.project = project;
        self.dueDate = dueDate;
        self.url = url;
        self.completed = completed;
        self.wsType = wstype;
    }
    return self;
}

-(id)initWithTitle:(NSString *)title {
    if((self = [super init])){
        self.title = title;
    }
    return self;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"{Task: {title:%@, wsId:%i, completed: %@, desc: %@}}", self.title, self.wsId, self.completed ? @"YES":@"NO", self.desc];
}


@end
