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
@synthesize baseUrlString = _baseUrlString;

- (id) initWithTitle:(NSString *)title desc:(NSString *)desc type:(int) wsType {
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        type = wsType;
    }
    return self;
}

- (id) initWithTitle:(NSString *)title desc:(NSString *)desc type:(int) wsType baseUrl:(NSString *)bUrlString imagePath:(NSString *) imgPath {
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        type = wsType;
        self.baseUrlString = bUrlString;
        self.imagePath = imgPath;
    }
    return self;
}

- (void) setAuthUsername: (NSString *)name andPassword:(NSString *)pw {
    self.username = name;
    self.password = pw;
}

- (NSString *) getUsername {
    return self.username;
}

- (NSString *) getPassword {
    return self.password;
}

- (int)type {
    return type;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"WS: Type:%i Title:%@ Img:%@ bURL: %@ Desc:%@", self.type, self.title, self.imagePath, self.baseUrlString, self.desc];
}

@end
