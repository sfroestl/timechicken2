//
//  TCWebservice.m
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCWebserviceEntity.h"

@implementation TCWebserviceEntity

+ (NSArray *) webserviceNames {
    static NSArray *wsNames;
    if (!wsNames) {
        wsNames = [[NSArray alloc] initWithObjects:@"Local", @"One Spark", @"Jira", nil];
    }
    return wsNames;
}

+ (NSArray *) webserviceDescriptions {
    static NSArray *wsNames;
    if (!wsNames) {
        wsNames = [[NSArray alloc] initWithObjects:
                   @"Local",
                   @"Make your idea happen!",
                   @"JIRA ist ein Projektverfolgungstool für Teams", nil];
    }
    return wsNames;
}

+ (NSArray *) webserviceImages {
    static NSArray *wsNames;
    if (!wsNames) {
        wsNames = [[NSArray alloc] initWithObjects:@"", @"icon-os.png", @"jiraThumb.png", nil];
    }
    return wsNames;
}

- (id) initWithTitle:(NSString *)title{
    if((self = [super init])){
        self.title = title;
    }
    return self;
}

@end
