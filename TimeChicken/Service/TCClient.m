//
//  TCClient.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCClient.h"

#import "TCWebservice.h"
#import "TCOneSparkClient.h"
#import "TCJiraClient.h"

@implementation TCClient


+ (TCOneSparkClient *)oneSparkClient {
    TCOneSparkClient *oneSparkClient = nil;
    oneSparkClient = [[TCOneSparkClient alloc] init];    
    return oneSparkClient;
}

+ (TCOneSparkClient *)oneSparkClientWithBaseUrl:(NSString *)baseUrlString {
    static TCOneSparkClient *_oneSparkClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _oneSparkClient = [[TCOneSparkClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrlString]];
    });
    
    return _oneSparkClient;
}

+ (TCOneSparkClient *)oneSparkClientWithWebservice:(TCWebservice *)ws {
    static TCOneSparkClient *_oneSparkClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _oneSparkClient = [[TCOneSparkClient alloc] initWithBaseURL:[NSURL URLWithString:ws.baseUrlString]];
        [_oneSparkClient setAuthorizationHeaderWithUsername:ws.username password:ws.password];
    });
    
    return _oneSparkClient;
}

+ (TCJiraClient *)jiraClientWithBaseUrl:(NSString *)baseUrlString {
    TCJiraClient *jiraClient = [[TCJiraClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrlString]];
    return jiraClient;
//    static TCJiraClient *_jiraClient = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _jiraClient = [[TCJiraClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrlString]];
//    });
//    
//    return _jiraClient;
}


+ (TCJiraClient *)jiraClientWithWebservice:(TCWebservice *)ws {
    static TCJiraClient *_jiraClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _jiraClient = [[TCJiraClient alloc] initWithBaseURL:[NSURL URLWithString:ws.baseUrlString]];
        [_jiraClient setAuthorizationHeaderWithUsername:ws.username password:ws.password];
    });
    
    return _jiraClient;
}

@end
