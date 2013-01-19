//
//  TCRestClient.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@class TCWebservice;

@interface TCRestClient : AFHTTPClient

+ (TCRestClient *)oneSparkClient;
+ (TCRestClient *)jiraClientWithBaseUrl:(NSString *)baseUrlString;

+ (TCRestClient *)oneSparkClientWithWebservice:(TCWebservice *)ws;
+ (TCRestClient *)jiraClientWithWebservice:(TCWebservice *)ws;
@end
