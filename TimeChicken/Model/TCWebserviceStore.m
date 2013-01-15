//
//  TCWebserviceStore.m
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCWebserviceStore.h"

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

- (void) addWebservice:(TCWebservice *)webservice {
    [webservices addObject:webservices];
}
- (void) removeWebservice:(TCWebservice *)webservice {
    [webservices removeObjectIdenticalTo:webservice];
    
}

@end
