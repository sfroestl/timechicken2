//
//  TCJiraClient.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCJiraClient.h"

#import "AFJSONRequestOperation.h"
#import "TCWebservice.h"
#import "TCTask.h"

NSString *const kJiraTasksPath = @"issue";
NSString *const kJiraRestPath = @"rest/api/2";
NSString *const kJiraProjectsPath = @"project";
NSString *const kJiraUserPath = @"/rest/auth/1/session";

@implementation TCJiraClient

@synthesize jiraBaseUrl = _jiraBaseUrl;

#pragma mark - NSObject

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    self.jiraBaseUrl = url;
    return self;
}

#pragma mark - Private

- (void)setBasicAuthUsername:(NSString *)name andPassword:(NSString *)pw {
    [self setAuthorizationHeaderWithUsername:name password:pw];
}

- (void)fetchUsername:(void (^)(NSString *, NSError *))block {
    NSString *getUserUrl = [NSString stringWithFormat:@"%@%@", self.baseURL, kJiraUserPath];
    
    [self getPath:getUserUrl parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *resp) {
        NSLog(@"-->> Jira Response fetchUser");
        NSLog(@"-->> %@", resp);
        NSLog(@"-->> %@", [resp valueForKeyPath:@"name"]);
        NSString *username = [resp valueForKeyPath:@"name"];
        if (block) {
            block(username, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

- (void)fetchUserTaskList:(void (^)(NSArray *tasks, NSError *error))block withWebservice:(TCWebservice *)ws {
    NSString *getTasksUrl = [NSString stringWithFormat:@"%@/rest/api/2/search?jql=assignee='%@'+order+by+duedate&fields=id,self,summary,description,duedate,project,status,assignee", ws.baseUrlString, ws.username];
    
    [self getPath:getTasksUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"-->> Jira Response fetchTasks");
        NSArray *dataFromResponse = [JSON valueForKeyPath:@"issues"];
        NSLog(@"-->> %@", dataFromResponse);
        NSMutableArray *mutableTasks = [NSMutableArray arrayWithCapacity:[dataFromResponse count]];
        for (NSDictionary  *attributes in dataFromResponse) {
            TCTask *task = [[TCTask alloc] initWithJiraAttributes:attributes wsType:ws.type wsID:ws.wsID];
            [mutableTasks addObject:task];
        }
        if (block) {
            block([NSArray arrayWithArray:mutableTasks], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

- (void)fetchUserProjectList:(void (^)(NSArray *, NSError *))block withWebservice:(TCWebservice *)ws{
    
}

@end
