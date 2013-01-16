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
@class TCRestClient;

@protocol TCRestClientDelegate <NSObject>
@required
- (void) resetClientFinished:(TCRestClient*)restClient;
- (void) restClient:(TCRestClient*)restClient failedWithError:(NSError*)error;
@end

@interface TCRestClient : NSObject{
    NSMutableData *urlData;
    NSURLConnection *connection;
    NSString *projectsUrl;
    NSURL *tasksUrl;
    NSString *timesessionUrl;    
    NSArray *taskList;
    __weak id <TCRestClientDelegate> restClientDelegate;
}
@property (nonatomic, weak) id <TCRestClientDelegate> restClientDelegate;
@property (nonatomic, strong)  NSDictionary *jsonResponse;



- (id)initOneSparkRestClientwithDelegate:(id<TCRestClientDelegate>) delegate;


- (void) fetchUserTaskList;

@end

