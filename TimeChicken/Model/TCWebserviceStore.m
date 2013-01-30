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

+ (int)generateWsId {
    static int wsId = 0;
    wsId = wsId + 1;
    return wsId;
}

- (id)init {
    self = [super init];
    if(self) {
        NSString *path = [self wsArchivePath];
        webservices = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if(!webservices){
            webservices = [[NSMutableArray alloc] init];
        }
        
        wsNames = [[NSArray alloc] initWithObjects:@"", @"One Spark", @"Jira", nil];
        wsDescs = [[NSArray alloc] initWithObjects:@"", 
                   @"One Spark - Make your idea happen!\n\nOne Spark ist ein Projektmanagement-Portal, das einzelnen Nutzern und auch großen Teams ermöglicht effizient an Projekten zu arbeiten.\n\nModulweise können andere Tools als Plugins eingebunden werden.",
                   @"JIRA ist ein Projektverfolgungstool für Teams, die großartige Software erstellen wollen.\n\nTausende Teams haben sich für JIRA entschieden, um Ihre Aufgaben besser zu koordinieren. Mit JIRA ist man immer informiert, woran das Team gerade arbeitet. ", nil];
        wsImagePaths = [[NSArray alloc] initWithObjects:@"icon-tc", @"icon-onespark", @"icon-jira", nil];
        wsBaseUrls = [[NSArray alloc] initWithObjects:@"", @"http://api.onespark.de:81/api/v1", @"http://jira.yourdomain.de", nil];
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
    return contains;
}

-(NSString *)wsArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirecty = [documentDirectories objectAtIndex:0];
    
    return [documentDirecty stringByAppendingPathComponent:@"webservices.archive"];
}

-(BOOL)saveChanges {
    NSString *path = [self wsArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:webservices toFile:path];
}




@end
