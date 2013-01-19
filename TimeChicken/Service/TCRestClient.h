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
- (void) fetchUser;
- (void)setAuthCredentials:(NSString*)userName password:(NSString *)pw;
@end

@interface TCRestClient : NSObject <TCRestClientIF>{
    NSMutableData *urlData;
    NSURLConnection *connection;
    
    NSURL *projectsUrl;
    NSURL *tasksUrl;
    NSURL *userUrl;
    NSURL *timesessionUrl;
    
    NSArray *taskList;
    __weak id <TCRestClientDelegate> _restClientDelegate;
}
@property (nonatomic, weak) id <TCRestClientDelegate> restClientDelegate;
@property (nonatomic, strong)  NSDictionary *jsonResponse;
@property (strong) NSString *username;
@property (strong) NSString *password;

- (id)initRestClientwithDelegate:(id<TCRestClientDelegate>) delegate;

@end

