//
//  TCRestClient.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Base64;
@class TCTask;

@interface TCRestClient : NSObject{    
    NSMutableData *urlData;
    NSURLConnection *connection;
    NSString *projectsUrl;
    NSURL *tasksUrl;
    NSString *timesessionUrl;
}

- (id)initOneSparkRestClient;

- (NSArray *) getUserTaskList;
- (NSArray *) getTimeSessionsOfTask:(TCTask *)task;

@end
