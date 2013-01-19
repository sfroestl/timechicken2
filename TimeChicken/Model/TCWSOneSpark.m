//
//  TCWSOneSpark.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCWSOneSpark.h"
#import "TCWebserviceEntity.h"

@implementation TCWSOneSpark

@synthesize baseUrl = _baseUrl;
@synthesize username = _username;
@synthesize password = _password;
@synthesize title = _title;
@synthesize desc = _desc;
@synthesize image = _image;

- (id) init {
    self = [super init];
    if (self) {
        self.title = [[TCWebserviceEntity webserviceNames] objectAtIndex:1];
        self.image = [[TCWebserviceEntity webserviceImages] objectAtIndex:1];
        self.desc = [[TCWebserviceEntity webserviceDescriptions] objectAtIndex:1];
    }
    return self;
}
- (id) initWithTitle:(NSString *)title{
    if((self = [super init])){
        self.title = title;
        self.image = [[TCWebserviceEntity webserviceImages] objectAtIndex:1];
        self.desc = [[TCWebserviceEntity webserviceDescriptions] objectAtIndex:1];
    }
    return self;
}

- (id) initWithBaseUrl:(NSURL *)baseUrl andTitle: (NSString *)title{
    if((self = [super init])){
        self.title = title;
        self.baseUrl = baseUrl;
        self.image = [[TCWebserviceEntity webserviceImages] objectAtIndex:1];
        self.desc = [[TCWebserviceEntity webserviceDescriptions] objectAtIndex:1];
    }
    return self;
}

@end
