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
        _wsID = [TCWebservice generateWsId];
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
        _wsID = [TCWebservice generateWsId];
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

- (int) getWsID {
    return _wsID;
}

- (int)type {
    return type;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"WS: Type:%i Title:%@ Username:%@ WSID:%i Img:%@ bURL: %@ Desc:%@", self.type, self.title, self.username, self.wsID, self.imagePath, self.baseUrlString, self.desc];
}

+ (int)generateWsId {
    static int wsId = 0;
    wsId = wsId + 1;
    return wsId;
}

@end
