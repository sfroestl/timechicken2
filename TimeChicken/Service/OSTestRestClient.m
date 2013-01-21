//
//  TCOneSparkRestClient.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "OSTestRestClient.h"
#import "TCTask.h"
#import "Base64.h"

NSString* const baseUrl = @"http://api.onespark.de:81/api/v1";
NSString* const userUrlPart = @"/user";
NSString* const tasksUrlPart = @"/tasks";
NSString* const projectsUrlPart = @"/projects";

@implementation OSTestRestClient
@synthesize jsonResponse = _jsonResponse;
@synthesize restClientDelegate = _restClientDelegate;

@synthesize username = _username;
@synthesize password = _password;

#pragma mark - NSObject

- (id)initRestClientwithDelegate:(id<TCRestClientDelegate>) delegate
{
    self = [super init];
    if (self) {
        self.restClientDelegate = delegate;
        tasksUrl = [[NSURL alloc] initWithString: [NSString stringWithFormat:@"%@%@", baseUrl, tasksUrlPart]];
        userUrl = [[NSURL alloc] initWithString: [NSString stringWithFormat:@"%@%@", baseUrl, userUrlPart]];
    }
    return self;
}

#pragma mark - Private

- (void)setAuthCredentials:(NSString*)userName password:(NSString *)pw {
    NSLog(@"--> setAuthCredentials");
    self.username = userName;
    self.password = pw;
}

- (void) fetchUserTaskList
{
    NSLog(@"--> fetchUserTaskList");
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.username, self.password];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [Base64 base64String:authStr]];
    NSLog(@"Basic64: %@", authValue);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tasksUrl];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void) fetchUserProjectList {}

- (void) fetchUser {
    NSLog(@"--> fetchUser");
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.username, self.password];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [Base64 base64String:authStr]];
    NSLog(@"Basic64: %@", authValue);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:userUrl];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (BOOL) updateTask
{
    return YES;
}

- (NSArray *) getTimeSessionsOfTask:(TCTask *)task
{
    return [[NSArray alloc] init];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"One Spark Rest Client"];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    NSLog(@"Response Received! Status:  %u", code);
    urlData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [urlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *jsonParsingError = nil;
    id object = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&jsonParsingError];
    
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
    } else {
        NSLog(@"OBJECT LOADED!");
    }
    self.jsonResponse = object;
    [self.restClientDelegate resetClientFinished:self];
}

- (void) resetClientFinished:(OSTestRestClient*)restClient{
}

- (void) restClient:(OSTestRestClient*)restClient failedWithError:(NSError*)error{
}
@end


