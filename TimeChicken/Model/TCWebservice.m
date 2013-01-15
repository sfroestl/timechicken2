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
@synthesize image = _image;

- (id) initWithTitle:(NSString *)title{
    if((self = [super init])){
        self.title = title;
    }
    return self;
}

@end
