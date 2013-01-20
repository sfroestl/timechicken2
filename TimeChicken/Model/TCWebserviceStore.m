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
        wsNames = [[NSArray alloc] initWithObjects:@"", @"One Spark", @"Jira", nil];
        wsDescs = [[NSArray alloc] initWithObjects:@"", 
                   @"Make your idea happen!",
                   @"JIRA ist ein Projektverfolgungstool für Teams", nil];
        wsImagePaths = [[NSArray alloc] initWithObjects:@"", @"icon-os.png", @"jiraThumb.png", nil];
        wsBaseUrls = [[NSArray alloc] initWithObjects:@"", @"http://api.onespark.de:81/api/v1", @"http://jira.yourdomain.de", nil];
        
        TCWebservice *osService = [[TCWebservice alloc] initWithTitle:@"One Spark" desc:[wsDescs objectAtIndex:ONESPARK] type:ONESPARK baseUrl:[wsBaseUrls objectAtIndex:ONESPARK] imagePath:[wsImagePaths objectAtIndex:ONESPARK]];
        osService.username = @"sfroestl";
        osService.password = @"asdasd";
        [webservices addObject:osService];
        
        TCWebservice *jiraService = [[TCWebservice alloc] initWithTitle:@"Jira" desc:[wsDescs objectAtIndex:JIRA] type:JIRA baseUrl:@"http://jira.inf.tu-dresden.de" imagePath:[wsImagePaths objectAtIndex:JIRA]];
        jiraService.username = @"froestl";
        jiraService.password = @"fr1bb3#RN";
        [webservices addObject:jiraService];
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
    TCWebservice * newWs = [[TCWebservice alloc] initWithTitle:[wsNames objectAtIndex:type]
                                                          desc:[wsDescs objectAtIndex:type]
                                                          type:type
                                                       baseUrl:[wsBaseUrls objectAtIndex:type]
                                                     imagePath:[wsImagePaths objectAtIndex:type]];
    return newWs;
}

- (TCWebservice *) webserviceWithType:(int)type andBaseUrl:(NSString *)bUrl {
    TCWebservice * newWs = [[TCWebservice alloc] initWithTitle:[wsNames objectAtIndex:type]
                                                          desc:[wsDescs objectAtIndex:type]
                                                          type:type
                                                       baseUrl:bUrl
                                                     imagePath:[wsImagePaths objectAtIndex:type]];
    return newWs;
}

- (void) addWebservice:(TCWebservice *)webservice {
    [webservices addObject:webservice];
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


- (BOOL) containsWs:(TCWebservice *)newWs {
    BOOL contains = false;
    for (TCWebservice *ws in webservices) {
        if ((ws.type == newWs.type) && ([ws.username isEqualToString:newWs.username]) && ([ws.baseUrlString isEqualToString:newWs.baseUrlString ])) {
            contains = true;
            break;
        }
    }
    NSLog(@"Contains: %i", contains);
    return contains;
}


@end
