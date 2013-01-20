//
//  TCWebservice.h
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {ONESPARK, JIRA};
typedef NSUInteger WS_TYPES;

@interface TCWebservice : NSObject {
    int type;
}

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imagePath;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *baseUrlString;

@property int wsID;

+ (int)generateWsId;


- (id) initWithTitle:(NSString *)title desc:(NSString *)desc type:(int) wsType;
- (id) initWithTitle:(NSString *)title desc:(NSString *)desc type:(int) wsType baseUrl:(NSString *)bUrlString imagePath:(NSString *) imgPath;
- (void) setAuthUsername: (NSString *)name andPassword:(NSString *)pw;

- (NSString *)username;
- (NSString *)password;
- (int)type;

@end
