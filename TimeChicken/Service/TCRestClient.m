//
//  TCOneSparkRestClient.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCRestClient.h"
#import "TCTask.h"
#import "Base64.h"


@implementation TCRestClient

- (id)initOneSparkRestClient {
    self = [super init];
    tasksUrl = [[NSURL alloc] initWithString:@"http://api.onespark.de/api/v1/tasks"];
    return self;
}

- (NSArray *) getUserTaskList{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"sfroestl", @"asdasd"];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [Base64 base64String:authStr]];
    NSLog(@"Basic64: %@", authValue);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tasksUrl];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    return [[NSArray alloc] init];
}

- (BOOL) updateTask{
    return YES;
}

- (NSArray *) getTimeSessionsOfTask:(TCTask *)task{
    return [[NSArray alloc] init];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"One Spark Rest Client"];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    NSLog(@"Response Received! Status:  %u", code);
    urlData = [[NSMutableData alloc] init];
    NSLog(@"%@", urlData);

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [urlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *jsonParsingError = nil;
    id object = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&jsonParsingError];
    
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
    } else {
        NSLog(@"OBJECT: %@", object);
    }
}



@end


