//
//  TCWebserviceStore.m
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCWebserviceStore.h"
#import "TCWebservice.h"


@implementation TCWebserviceStore


+ (TCWebserviceStore *)wsStore {
    static TCWebserviceStore *wsStore = nil;
    if(!wsStore)
        wsStore = [[super allocWithZone:nil] init];
    return wsStore;    
}

+ (id)allocWithZone:(NSZone *)zone  {
    return [self wsStore];
}

- (id)init {
    self = [super init];
    if(self) {
        webservices = [[NSMutableArray alloc] init];
        wsNames = [[NSArray alloc] initWithObjects:@"One Spark", @"Jira", nil];
        wsDescs = [[NSArray alloc] initWithObjects:
                   @"Make your idea happen!",
                   @"JIRA ist ein Projektverfolgungstool für Teams", nil];
        wsImagePaths = [[NSArray alloc] initWithObjects: @"icon-os.png", @"jiraThumb.png", nil];
    }
    return self;
}

- (NSArray *) allWebservices {
    return webservices;
}

- (NSArray *) wsNames {
    return wsNames;
}

- (NSString *) wsNameofType:(int) type {
    return [wsNames objectAtIndex:type];
}

- (NSString *) wsDescriptionOfType:(int) type {
    return [wsDescs objectAtIndex:type];
}

- (NSString *) wsImageOfType:(int) type {
    return [wsImagePaths objectAtIndex:type];
}

- (TCWebservice *) webserviceWithType:(int)type {
    TCWebservice * newWs = [[TCWebservice alloc] initWithTitle:[wsNames objectAtIndex:type] desc:[wsDescs objectAtIndex:type] type:type];
    return newWs;
}

- (TCWebservice *) webserviceWithType:(int)type andBaseUrl:(NSURL *)bUrl {
    TCWebservice * newWs = [[TCWebservice alloc] initWithTitle:[wsNames objectAtIndex:type] desc:[wsDescs objectAtIndex:type] type:type andBaseUrl:bUrl];
    return newWs;
}

- (void) addWebservice:(TCWebservice *)webservice {
    [webservices addObject:webservices];
}

- (void) removeWebservice:(TCWebservice *)webservice {
    [webservices removeObjectIdenticalTo:webservice];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
    if (from == to){
        return;
    }
    TCWebservice *ws = [webservices objectAtIndex:from];    
    // Remove item from array
    [webservices removeObjectAtIndex:from];
    // Insert item in array at new location
    [webservices insertObject:ws atIndex:to];
}

@end
