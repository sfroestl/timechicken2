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
@synthesize jsonResponse = _jsonResponse;
@synthesize restClientDelegate = restClientDelegate;

- (void) fetchUserTaskList{}
- (void) fetchUserProjectList{}
- (id)initRestClientwithDelegate:(id<TCRestClientDelegate>) delegate {
    self = [super init];
    restClientDelegate = delegate;
    return self;
}
@end


