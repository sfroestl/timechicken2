//
//  TCRestClientIF.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TCRestClientIF <NSObject>

@required

- (void)fetchUsername:(void (^)(NSString *username, NSError *error))block;
- (void)fetchUserTaskList:(void (^)(NSArray *tasks, NSError *error))block withWebservice:(TCWebservice *)ws;
- (void) fetchUserProjectList:(void (^)(NSArray *projects, NSError *error))block withWebservice:(TCWebservice *)ws;
- (void)setBasicAuthUsername:(NSString *)name andPassword:(NSString *)pw;

@end