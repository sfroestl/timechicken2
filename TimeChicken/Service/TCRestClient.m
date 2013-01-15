//
//  TCOneSparkRestClient.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCRestClient.h"
#import "TCTask.h"


@implementation TCRestClient

- (id)initOneSparkRestClient {
    self = [super init];
    tasksUrl = [[NSURL alloc] initWithString:@"http://api.onespark.de/api/v1/tasks"];
    return self;
}

- (NSArray *) getUserTaskList{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"sfroestl", @"asdasd"];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [TCRestClient base64String:authStr]];
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


+ (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
@end


