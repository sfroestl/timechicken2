//
//  TCWebserviceStore.h
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCWebserviceEntity;

@interface TCWebserviceStore : NSObject {
     NSMutableArray *webservices;
}

+ (TCWebserviceStore *)webservices;

- (NSArray *) allWebservices;
- (TCWebserviceEntity *) createNewWebservice;
- (TCWebserviceEntity *) createWebserviceWithType:(int)type;
- (void) addWebservice:(TCWebserviceEntity *)webservice;
- (void) removeWebservice:(TCWebserviceEntity *)webservice;
- (void) moveItemAtIndex:(int)from toIndex:(int)to;

@end
