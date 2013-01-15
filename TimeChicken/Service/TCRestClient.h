//
//  TCRestClient.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

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
+ (NSString *)base64String:(NSString *)str;

@end
