//
//  TCWebservice.m
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCWebservice.h"

@implementation TCWebservice

@synthesize title = _title;
@synthesize desc = _desc;
@synthesize baseUrl = _baseUrl;

- (id) initWithTitle:(NSString *)title desc:(NSString *)desc type:(int) wsType {
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        type = type;
    }
    return self;
}

- (id) initWithTitle:(NSString *)title desc:(NSString *)desc type:(int) wsType andBaseUrl:(NSURL *)bUrl {
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        type = type;
        self.baseUrl = bUrl;
    }
    return self;
}

- (void) setAuthUsername: (NSString *)name andPassword:(NSString *)pw {
    self.username = name;
    self.password = pw;
}

- (NSString *)username {
    return self.username;
}

- (NSString *)password {
    return self.password;
}

@end
