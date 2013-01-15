//
//  TCWebserviceStore.h
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCWebservice;

@interface TCWebserviceStore : NSObject {
     NSMutableArray *webservices;
}

+ (TCWebserviceStore *)webservices;

- (NSArray *) allWebservices;
- (void) addWebservice:(TCWebservice *)webservice;
- (void) removeWebservice:(TCWebservice *)webservice;

@end
