//
//  TCWebservice.h
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {LOCAL, ONESPARK, JIRA};
typedef NSUInteger WS_TYPES;


@interface TCWebserviceEntity : NSObject {
    NSArray *wsNames;
}

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *password;
@property(strong, nonatomic) NSURL *baseUrl;

+ (NSArray *) webserviceNames;
+ (NSArray *) webserviceDescriptions;
+ (NSArray *) webserviceImages;

- (id) initWithTitle:(NSString *)title;

@end
