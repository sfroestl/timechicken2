//
//  TCClient.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@class TCOneSparkClient;
@class TCJiraClient;
@class TCWebservice;

@interface TCClient : AFHTTPClient

+ (TCOneSparkClient *)oneSparkClient;
+ (TCOneSparkClient *)oneSparkClientWithBaseUrl:(NSString *)baseUrlString;
+ (TCOneSparkClient *)oneSparkClientWithWebservice:(TCWebservice *)ws;

+ (TCJiraClient *)jiraClientWithBaseUrl:(NSString *)baseUrlString;
+ (TCJiraClient *)jiraClientWithWebservice:(TCWebservice *)ws;

@end
