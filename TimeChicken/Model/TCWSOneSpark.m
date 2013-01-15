//
//  TCWSOneSpark.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCWSOneSpark.h"

@implementation TCWSOneSpark

@synthesize baseUrl = _baseUrl;
@synthesize username = _username;
@synthesize password = _password;

- (id) initWithBaseUrl:(NSURL *)baseUrl andTitle: (NSString *)title{
    if((self = [super init])){
        self.title = title;
        self.baseUrl = baseUrl;
    }
    return self;
}
@end
