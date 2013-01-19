//
//  TCRestClient.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCRestClient.h"

#import "TCWebservice.h"
#import "AFJSONRequestOperation.h"

static NSString * const kOSAPIBaseURLString = @"http://api.onespark.de/api/v1";

@implementation TCRestClient


+ (TCRestClient *)oneSparkClient {
    static TCRestClient *_oneSparkClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _oneSparkClient = [[TCRestClient alloc] initWithBaseURL:[NSURL URLWithString:kOSAPIBaseURLString]];
    });
    
    return _oneSparkClient;
}

+ (TCRestClient *)jiraClientWithBaseUrl:(NSString *)baseUrlString {
    static TCRestClient *_jiraClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _jiraClient = [[TCRestClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrlString]];
    });
    
    return _jiraClient;    
}

+ (TCRestClient *)oneSparkClientWithWebservice:(TCWebservice *)ws {
    static TCRestClient *_oneSparkClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _oneSparkClient = [[TCRestClient alloc] initWithBaseURL:[NSURL URLWithString:ws.baseUrlString]];
        [_oneSparkClient setAuthorizationHeaderWithUsername:ws.username password:ws.password];
    });
    
    return _oneSparkClient;
}

+ (TCRestClient *)jiraClientWithWebservice:(TCWebservice *)ws {
    static TCRestClient *_jiraClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _jiraClient = [[TCRestClient alloc] initWithBaseURL:[NSURL URLWithString:ws.baseUrlString]];
        [_jiraClient setAuthorizationHeaderWithUsername:ws.username password:ws.password];
    });
    
    return _jiraClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}


@end
