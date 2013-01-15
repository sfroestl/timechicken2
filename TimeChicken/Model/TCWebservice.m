//
//  TCWebservice.m
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCWebservice.h"

@implementation TCWebservice

@synthesize baseUrl = _baseUrl;
@synthesize title = _title;
@synthesize username = _username;
@synthesize password = _password;

- (id) initWithBaseUrl:(NSURL *)baseUrl andTitle: (NSString *)title{
    if((self = [super init])){
        self.title = title;
        self.baseUrl = baseUrl;
    }
    return self;
}

- (id) initWithTitle:(NSString *)title{
    if((self = [super init])){
        self.title = title;
    }
    return self;
}

@end
