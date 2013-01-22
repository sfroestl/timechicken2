//
//  TCRestClient.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCOneSparkClient.h"
#import "TCTask.h"
#import "TCWebservice.h"
#import "AFJSONRequestOperation.h"


NSString *const kTasksPath = @"/tasks";
NSString *const kProjectsPath = @"/projects";
NSString *const kUserPath = @"/user";
NSString *const kOSAPIBaseURLString = @"http://api.onespark.de:81/api/v1";

@implementation TCOneSparkClient

#pragma mark - NSObject

- (id)init {
   self = [super initWithBaseURL:[NSURL URLWithString:kOSAPIBaseURLString]];
   if (!self) {
       return nil;
   }
   [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
   [self setDefaultHeader:@"Accept" value:@"application/json"];
    
   return self;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

#pragma mark - Private

- (void)setBasicAuthUsername:(NSString *)name andPassword:(NSString *)pw {
    [self setAuthorizationHeaderWithUsername:name password:pw];
}

- (void)fetchUsername:(void (^)(NSString *username, NSError *error))block {
    NSString *getUserUrl = [NSString stringWithFormat:@"%@%@", kOSAPIBaseURLString, kUserPath];
    
    [self getPath:getUserUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"-->> OneSpark Response fetchUser");
        NSArray *dataFromResponse = [JSON valueForKeyPath:@"user"];
        NSLog(@"-->> %@", dataFromResponse);
        NSString *username = [dataFromResponse valueForKey:@"username"];
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
    NSString *getTasksUrl = [NSString stringWithFormat:@"%@%@", kOSAPIBaseURLString, kTasksPath];
    
    [self getPath:getTasksUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"-->> OneSpark Response fetchTasks");
        NSArray *dataFromResponse = [JSON valueForKeyPath:@"tasks"];
        NSLog(@"-->> %@", dataFromResponse);
        NSMutableArray *mutableTasks = [NSMutableArray arrayWithCapacity:[dataFromResponse count]];
        for (NSDictionary  *attributes in dataFromResponse) {
            TCTask *task = [[TCTask alloc] initWithOneSparkAttributes:attributes wsType:ws.type wsID:ws.wsID];
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

- (void)fetchUserProjectList:(void (^)(NSArray *projects, NSError *error))block withWebservice:(TCWebservice *)ws {
    
}

@end
