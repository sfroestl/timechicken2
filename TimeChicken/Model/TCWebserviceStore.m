//
//  TCWebserviceStore.m
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCWebserviceStore.h"
#import "TCWebservice.h"
#import "TCWSOneSpark.h"

@implementation TCWebserviceStore


+ (TCWebserviceStore *)webservices {
    static TCWebserviceStore *webservices = nil;
    if(!webservices)
        webservices = [[super allocWithZone:nil] init];
    return webservices;    
}

+ (id)allocWithZone:(NSZone *)zone  {
    return [self webservices];
}

- (id)init {
    self = [super init];
    if(self) {
        webservices = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *) allWebservices {
    return webservices;
}

- (TCWebservice *)createNewWebservice {
    TCWebservice *newWS = [[TCWSOneSpark alloc] initWithTitle:@"New Webservice"];
    [webservices addObject:newWS];
    return newWS;
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
