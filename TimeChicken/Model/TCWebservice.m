//
//  TCWebservice.m
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCWebservice.h"
#import "TCWebserviceStore.h"

@implementation TCWebservice {
}

@synthesize title = _title;
@synthesize desc = _desc;
@synthesize baseUrlString = _baseUrlString;


- (id) initWithTitle:(NSString *)title desc:(NSString *)desc type:(int) wsType {
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        _type = wsType;
        _wsID = [TCWebserviceStore generateWsId];
    }
    return self;
}

- (id) initWithTitle:(NSString *)title desc:(NSString *)desc type:(int) wsType baseUrl:(NSString *)bUrlString imagePath:(NSString *) imgPath {
    if((self = [super init])){
        self.title = title;
        self.desc = desc;
        _type = wsType;
        self.baseUrlString = bUrlString;
        self.imagePath = imgPath;
        _wsID = [TCWebserviceStore generateWsId];
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
    return _type;
}

-(void)setType:(int)wsType{
    _type = wsType;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"WS: Type:%i Title:%@ Username:%@ WSID:%i Img:%@ bURL: %@ Desc:%@", self.type, self.title, self.username, self.wsID, self.imagePath, self.baseUrlString, self.desc];
}



//for persistant encoding into Document
-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.imagePath forKey:@"imagePath"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.username forKey:@"username"];
    //TODO: Password should be encrypted 
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.baseUrlString forKey:@"baseUrlString"];
    [aCoder encodeInt:self.wsID forKey:@"wsID"];
    [aCoder encodeInt:self.type forKey:@"type"];
}

//decoding from Document
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setImagePath:[aDecoder decodeObjectForKey:@"imagePath"]];
        [self setDesc:[aDecoder decodeObjectForKey:@"desc"]];
        [self setUsername:[aDecoder decodeObjectForKey:@"username"]];
        [self setPassword:[aDecoder decodeObjectForKey:@"password"]];
        [self setBaseUrlString:[aDecoder decodeObjectForKey:@"baseUrlString"]];
        [self setWsID:[aDecoder decodeIntForKey:@"wsID"]];
        [self setType:[aDecoder decodeIntForKey:@"type"]];
    }
    return self;
}

@end
