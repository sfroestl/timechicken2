//
//  TCWebservice.h
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCWebservice : NSObject

@property (strong, nonatomic) NSURL *baseUrl;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

- (id) initWithBaseUrl:(NSURL *)baseUrl andTitle: (NSString *)title;
@end
