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
    NSArray *wsNames;
    NSArray *wsDescs;
    NSArray *wsImagePaths;
    NSArray *wsBaseUrls;
}

+ (TCWebserviceStore *)wsStore;

-(NSString *)wsArchivePath;
-(BOOL) saveChanges;

- (NSArray *) wsNames;
- (NSString *) wsNameofType:(int) type;
- (NSString *) wsDescriptionOfType:(int) type;
- (NSString *) wsImageOfType:(int) type;

- (NSArray *) allWebservices;

- (TCWebservice *) webserviceWithType:(int)type;
- (TCWebservice *) webserviceWithType:(int)type andBaseUrl:(NSURL *) bUrl;

- (void) addWebservice:(TCWebservice *)webservice;
- (void) removeWebservice:(TCWebservice *)webservice;
- (void) moveItemAtIndex:(int)from toIndex:(int)to;

- (BOOL) containsWs:(TCWebservice *)newWs;

@end
