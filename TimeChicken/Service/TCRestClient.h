//
//  TCRestClient.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCRestClientDelegate.h"
#import "TCTask.h"
@protocol TCRestClientIF <NSObject>
@required
- (void) fetchUserTaskList;
- (void) fetchUserProjectList;
@end

@interface TCRestClient : NSObject <TCRestClientIF>{
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

- (id)initRestClientwithDelegate:(id<TCRestClientDelegate>) delegate;

@end

