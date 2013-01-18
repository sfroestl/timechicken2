//
//  TCWSOneSpark.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCWebserviceEntity.h"
#import "TCTask.h"

@interface TCWSOneSpark : TCWebserviceEntity

@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *password;
@property(strong, nonatomic) NSURL *baseUrl;

- (id) initWithBaseUrl:(NSURL *)baseUrl andTitle: (NSString *)title;

@end
