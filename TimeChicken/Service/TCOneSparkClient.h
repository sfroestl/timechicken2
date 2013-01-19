//
//  TCRestClient.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCClient.h"
#import "TCRestClientIF.h"

FOUNDATION_EXPORT NSString *const kTasksPath;
FOUNDATION_EXPORT NSString *const kProjectsPath;
FOUNDATION_EXPORT NSString *const kUsersPath;

@interface TCOneSparkClient : TCClient <TCRestClientIF>

@end
